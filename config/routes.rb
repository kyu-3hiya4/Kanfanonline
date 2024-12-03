Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
