Rails.application.routes.draw do
  resources :active_storage_blobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#index"
  resources :homes
  resources :users do
    resources :decentralizations, only: [:edit]
    resources :reports, only: [:new, :create]
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :reports, only: [:new, :create]
    resources :notifications, only: [:update]
  end
  resources :notifications, only: [:index, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :activity_logs, only: [:index, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get "/sign_up" , to: "users#new"
  # post "/sign_up" , to: "users#create"
  get "/sign_in" , to: "sessions#new"
  post "/sign_in" , to: "sessions#create"
  delete "/log_out",  to: "sessions#destroy"

  post "/tinymce_assets", to: "tinymce_assets#create"

  namespace :admin do
    resources :active_storage_blobs
    root "homes#index"
    get "/log_in", to: "sessions#new"
    post "/log_in", to: "sessions#create"
    delete "/log_out", to: "sessions#destroy"
    resources :reports, only: [:index, :show, :destroy]
    resources :post_types, except: [:show]
    resources :decentralizations, only: [:index, :edit, :update, :destroy]
    resources :activity_logs, only: [:index, :destroy]
    resources :notifications, only: [:index, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :users, only: [:index, :update, :show, :destroy]
  end

end
