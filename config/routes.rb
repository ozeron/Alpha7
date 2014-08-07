Rails.application.routes.draw do
  #get 'my_surveys/index'

  devise_for :users, :controllers => { registrations: 'profiles' }

  resources :surveys do
  end
  resources :sharing, only:[:show, :create]
  resources :my_surveys, only: [:index]
  root 'surveys#index'
end
