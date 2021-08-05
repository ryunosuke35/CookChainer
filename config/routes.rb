Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'posts#index'

  resources :posts do
    collection do
      get :index2
    end
  end

  devise_for :users

  resources :tags
  resources :categories
  resources :tag_categories
  resources :favorites, only: [:create, :destroy, :index]
  resources :users, only: [:show]

end
