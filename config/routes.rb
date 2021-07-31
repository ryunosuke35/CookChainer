Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  resources :posts
  resources :tags
  resources :categories
  resources :favorites, only: [:create, :destroy]
  root 'posts#index'




end
