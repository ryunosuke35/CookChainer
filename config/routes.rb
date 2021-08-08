Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'posts#index'

  resources :posts do
    collection do
      get :index2
    end
  end

  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :tags, except: [:show]
  resources :categories, except: [:show]
  resources :tag_categories, except: [:show]

  resources :favorites, only: [:create, :destroy, :index]
  resources :users, only: [:show, :edit, :update, :destroy]

end
