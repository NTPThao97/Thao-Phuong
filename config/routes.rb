Rails.application.routes.draw do
  resources :active_storage_blobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#index"
  resources :homes
  resources :users do
    resources :decentralizations, only: [:edit]
    resources :reports, only: [:new, :create]
  end
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :notifications, only: [:update]
    resources :reports, only: [:new, :create]
  end
  resources :notifications, only: [:index, :destroy]
  resources :decentralizations, only: [:index, :edit, :update, :destroy]
  resources :reports, only: [:create]

  get "/sign_up" , to: "users#new"
  post "/sign_up" , to: "users#create"
  get "/sign_in" , to: "sessions#new"
  post "/sign_in" , to: "sessions#create"

  post "/tinymce_assets", to: "tinymce_assets#create"

end
