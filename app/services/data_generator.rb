# app/services/data_generator.rb
require 'csv'
require 'fileutils'

module DataGenerator

  def self.generate_unique_email(email, user_type, unique_string)
    parts = email.split("@")
    part1 = parts[0]
    part2 = parts[1] 
    if user_type == 'staff'
      email = part1 + "+staff_#{unique_string}@#{part2}"
    elsif user_type == 'student'
      email = part1 + "+student_#{unique_string}@#{part2}"
    else
      email = part1 + "+guardian_#{unique_string}@#{part2}"
    end
  end

  def self.generate_staff_data(num_staff, email)
    FileUtils.mkdir_p('artifact') unless File.directory?('artifact')
    date_number = Time.now.strftime("%Y%m%d%H%M%S%L") 
  
    CSV.open('artifact/staff.csv', 'w') do |csv|  # Specify the path inside the 'artifact' folder
      csv << ['staff_email', 'staff_id', 'staff_first_name', 'staff_last_name']
  
      num_staff.times do |i|
        unique_string = "#{i+1}_#{date_number}"
        staff_email = generate_unique_email(email, 'staff', unique_string)
        staff_id =  "staff#{i+1}"
        staff_first_name = "John#{i+1}"
        staff_last_name = "Doe#{i+1}"
  
        csv << [staff_email, staff_id, staff_first_name, staff_last_name]
      end
    end
  end

  def self.generate_student_data(num_students, email)
    FileUtils.mkdir_p('artifact') unless File.directory?('artifact')
    date_number = Time.now.strftime("%Y%m%d%H%M%S%L")

    CSV.open('artifact/students.csv', 'w') do |csv|
    csv << ['student_email', 'student_id', 'student_first_name', 'student_last_name']

    num_students.times do |i| 
      unique_string = "#{i+1}_#{date_number}"
      student_email = generate_unique_email(email, 'student', unique_string)
      student_id = "student#{i+1}"
      student_first_name = "Jane#{i+1}"
      student_last_name = "Smith#{i+1}"

      csv << [student_email, student_id, student_first_name, student_last_name]
     end
    end
  end

  def self.generate_classes_data(num_classes, num_buildings)
    FileUtils.mkdir_p('artifact') unless File.directory?('artifact')
    CSV.open('artifact/classes.csv', 'w') do |csv|
        csv << ['class_id', 'class_name', 'Description', 'building_id']
    
        num_classes.times do |i|
          class_id = "ClassID#{i+1}"
          class_name = "Class#{i+1}"
          description = "This is class #{i}"
          building_id = 1000 + (i % num_buildings)
    
          csv << [class_id, class_name, description, building_id]
        end
      end
  end

  def self.generate_enrollment_data(num_classes, num_students_per_class, num_staff_per_class, num_staff, num_students)
    FileUtils.mkdir_p('artifact') unless File.directory?('artifact')
    length = num_students_per_class > num_staff_per_class ? num_students_per_class : num_staff_per_class;
    CSV.open('artifact/enrollment.csv', 'w') do |csv|
        csv << ['class_id', 'student_id', 'staff_id']
    
        num_classes.times do |i|
          class_id = "ClassID#{i+1}"
    
          length.times do |j|

            student_id = if j < num_students_per_class && j < num_students
                          "student#{i * num_students_per_class + j + 1}"
                         else
                          nil
                         end
            
            staff_id = if j < num_staff_per_class && j < num_staff
                         "staff#{i * num_staff_per_class + j + 1}"
                       else
                         nil
                       end
    
            csv << [class_id, student_id, staff_id]
          end
        end
      end
  end

  def self.generate_guardian_data(num_guardian, student_id, email)
    FileUtils.mkdir_p('artifact') unless File.directory?('artifact')
    date_number = Time.now.strftime("%Y%m%d%H%M%S%L") 
  
    CSV.open('artifact/guardian.csv', 'w') do |csv|  # Specify the path inside the 'artifact' folder
      csv << ['Student ID', 'FirstName', 'LastName', 'e-Mail']
  
      num_guardian.times do |i|
        unique_string = "#{i+1}_#{date_number}"
        guardian_email = generate_unique_email(email, 'guardian', unique_string)
        guardian_first_name = "Jason#{i+1}"
        guardian_last_name = "Doe#{i+1}"
  
        csv << [student_id, guardian_first_name, guardian_last_name, guardian_email]
      end
    end
  end
end
