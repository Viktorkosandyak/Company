Rails.application.routes.draw do

  root 'employees#index'
  devise_for :users
  resources :departaments
  resources :employees

end
