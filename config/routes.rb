Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  # get 'home/index'

  resources :tickets
  # get 'tickets/index'
  # get 'tickets/new'
  # get 'tickets/show'
  # get 'tickets/edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
