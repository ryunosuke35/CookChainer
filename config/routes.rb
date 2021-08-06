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
  resources :categories, except: [:show]
  resources :tag_categories, except: [:show]
  resources :favorites, only: [:create, :destroy, :index]
  resources :users, only: [:show, :edit, :update]

end
