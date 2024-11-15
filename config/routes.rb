Rails.application.routes.draw do

  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  devise_for :users
  root to: "homes#top"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
