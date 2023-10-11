require_relative '../services/data_generator'

class DataController < ApplicationController
  include DataGenerator

  def input
  end

  def generate
    num_staff = params[:num_staff].to_i
    num_students = params[:num_students].to_i
    num_classes = params[:num_classes].to_i
    num_buildings = params[:num_buildings].to_i
    num_students_per_class = params[:num_students_per_class].to_i
    num_staff_per_class = params[:num_staff_per_class].to_i

    DataGenerator.generate_staff_data(num_staff, 'apptegy.com')
    DataGenerator.generate_student_data(num_students, 'apptegy.com')
    DataGenerator.generate_classes_data(num_classes, num_buildings)
    DataGenerator.generate_enrollment_data(num_classes, num_students_per_class, num_staff_per_class)

    redirect_to root_path, notice: 'Data generated successfully!'
    session[:data_generation_complete] = true
  end

  def download_staff_csv
    send_file "#{Rails.root}/artifact/staff.csv"
  end

  def download_students_csv
    send_file "#{Rails.root}/artifact/students.csv"
  end

  def download_classes_csv
    send_file "#{Rails.root}/artifact/classes.csv"
  end

  def download_enrollment_csv
    send_file "#{Rails.root}/artifact/enrollment.csv"
  end
end