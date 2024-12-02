Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  resources :posts
  resources :users, only: [:show, :edit, :update, :destroy]
  get '/search', to: 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
