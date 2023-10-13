Rails.application.routes.draw do
  devise_for :users
  get '/input', to: 'data#input'
  post '/generate', to: 'data#generate'
  get 'download_staff_csv', to: 'data#download_staff_csv'
  get 'download_students_csv', to: 'data#download_students_csv'
  get 'download_classes_csv', to: 'data#download_classes_csv'
  get 'download_enrollment_csv', to: 'data#download_enrollment_csv'
  root 'data#input'

end
