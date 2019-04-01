Rails.application.routes.draw do
  resources :active_storage_blobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#index"
  resources :homes
  resources :users
  resources :posts

  get "/sign_up" , to: "users#new"
  post "/sign_up" , to: "users#create"
  get "/sign_in" , to: "sessions#new"
  post "/sign_in" , to: "sessions#create"

  post "/tinymce_assets", to: "tinymce_assets#create"
  resources :comments, only: [:index, :create]
  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment

end
