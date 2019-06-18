Rails.application.routes.draw do
  get 'joins/create'
  get 'joins/destroy'
  get 'users/show'
  root to: 'events#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  resources :events

  resources :users, only: [:show]

  resources :groups
end
