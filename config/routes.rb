Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'tops#index'

  resources :posts
  resources :tops, only: [:index]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end

  resources :tags, except: [:show]
  resources :categories, except: [:show]
  resources :tag_categories, except: [:show]

  resources :favorites, only: [:create, :destroy, :index]
  resources :users, only: [:show, :edit, :update, :destroy]

end
