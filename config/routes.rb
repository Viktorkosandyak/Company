Rails.application.routes.draw do

  root 'departaments#index'

  resources :departaments
  resources :employees
  devise_for :users

end
