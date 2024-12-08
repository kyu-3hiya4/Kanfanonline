Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:show, :destroy] 
    resources :comments, only: [:index, :destroy]
  end
  
  scope module: :public do
    root to: "homes#top"
    devise_for :users
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update, :destroy]
    get '/search', to: 'searches#search'
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
