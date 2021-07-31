Rails.application.routes.draw do
  devise_for :users

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  resources :posts
  resources :tags
  resources :categories
  root 'posts#index'




end
