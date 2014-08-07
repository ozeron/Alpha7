Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'profiles' }

  resources :surveys
  root 'surveys#index'

end
