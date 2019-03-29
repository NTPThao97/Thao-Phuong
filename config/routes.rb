Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#index"
  resources :homes
  resources :users
  resources :posts

  get "/signup" , to: "users#new"
  post "/signup" , to: "users#create"
  get "/signin" , to: "sessions#new"
  post "/signin" , to: "sessions#create"
end
