Rails.application.routes.draw do
  # root 'home#index'
  # get 'home/index'

  resources :tickets do
    member do
      get 'resolve'
    end
  end
  # get 'tickets/index'
  # get 'tickets/new'
  # get 'tickets/show'
  # get 'tickets/edit'

  devise_for :users
  resources :users, only: [:index, :show]

  authenticated :user do
    root 'tickets#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'home#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
