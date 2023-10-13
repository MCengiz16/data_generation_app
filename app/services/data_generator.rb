# app/services/data_generator.rb
require 'csv'
require 'fileutils'

module DataGenerator

  def self.generate_unique_email(email_user, domain, user_type, i)
    # chars = ('a'..'z').to_a + ('A'..'Z').to_a
    # random_string = (0...10).map { chars[rand(chars.length)] }.join
    date_number = Time.now.strftime("%Y%m%d%H%M%S%L") 
    unique_string = "#{i+1}_#{date_number}"
    if user_type == 'staff'
      email = email_user + "+staff_#{unique_string}@#{domain}"
    else
      email = email_user + "+student_#{unique_string}@#{domain}"
    end
  end

  def self.generate_staff_data(num_staff, email_user, domain)
    FileUtils.mkdir_p('artifact') unless File.directory?('artifact')
    staff_emails = []
    staff_ids = []
  
    CSV.open('artifact/staff.csv', 'w') do |csv|  # Specify the path inside the 'artifact' folder
      csv << ['staff_email', 'staff_id', 'staff_first_name', 'staff_last_name']
  
      num_staff.times do |i|
        staff_email = generate_unique_email(email_user, domain, 'staff', i)
        staff_id =  "staff#{i+1}"
        staff_first_name = "John#{i+1}"
        staff_last_name = "Doe#{i+1}"
  
        csv << [staff_email, staff_id, staff_first_name, staff_last_name]
  
        staff_emails << staff_email
        staff_ids << staff_id
      end
    end
  end

  def self.generate_student_data(num_students, email_user, domain)
    FileUtils.mkdir_p('artifact') unless File.directory?('artifact')
    student_emails = []
    student_ids = []

    CSV.open('artifact/students.csv', 'w') do |csv|
    csv << ['student_email', 'student_id', 'student_first_name', 'student_last_name']

    num_students.times do |i|
      student_email = generate_unique_email(email_user, domain, 'student', i)
      student_id = "student#{i+1}"
      student_first_name = "Jane#{i+1}"
      student_last_name = "Smith#{i+1}"

      csv << [student_email, student_id, student_first_name, student_last_name]

      student_emails << student_email
      student_ids << student_id
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
end
