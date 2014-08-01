Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'profiles' }

  root 'welcome#index'
  

end
