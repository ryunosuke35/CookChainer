Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  resources :posts do
    collection do
      get :index2
    end
  end
  resources :tags
  resources :categories
  resources :favorites, only: [:create, :destroy, :index]
  resources :tag_categories
  resources :users, only: [:show]
  
  root 'posts#index'

end
