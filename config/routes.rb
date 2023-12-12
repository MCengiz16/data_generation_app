Rails.application.routes.draw do
  get 'logs/index'
  devise_for :users
  get '/input', to: 'data#input'
  post '/generate', to: 'data#generate'
  post '/generate_guardian', to: 'pages#generate_guardian'
  get 'download_staff_csv', to: 'data#download_staff_csv'
  get 'download_students_csv', to: 'data#download_students_csv'
  get 'download_classes_csv', to: 'data#download_classes_csv'
  get 'download_enrollment_csv', to: 'data#download_enrollment_csv'
  get 'download_guardian_csv', to: 'pages#download_guardian_csv'
  root 'data#input'
  get 'data/guardian'
  get 'data/guardian', to: 'data#guardian'
  resources :logs, only: [:index]

end
