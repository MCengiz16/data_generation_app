require_relative '../services/data_generator'

class PagesController < ApplicationController
  include DataGenerator

  def guardian
  end

def generate_guardian
  num_guardian = params[:num_guardian].to_i
  num_student_id = params[:num_student_id].to_i
  guardian_email = params[:guardian_email]

  DataGenerator.generate_guardian_data(num_guardian, num_student_id, guardian_email)

  redirect_to root_path, notice: 'Data generated successfully!'
  session[:data_generation_complete] = true
end

def download_guardian_csv
  send_file "#{Rails.root}/artifact/guardian.csv"
end
end