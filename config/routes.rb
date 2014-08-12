Rails.application.routes.draw do
  #get 'my_surveys/index'

  devise_for :users, :controllers => { registrations: 'profiles' }

  resources :surveys do
    member do
      patch 'submit', action: :submit
      get 'result'
    end
  end
  resources :sharing, only:[:show, :create]
  resources :my_surveys, only: [:index]
  root 'surveys#index'
end
