Rails.application.routes.draw do
  resources :anons do
    resources :comments, only: [:create, :destroy]
  end
  root "anons#index"

  resources :users, only: [:new, :create]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'users/:id/anons', to: 'users#anons', as: 'user_anons'
  post '/logout', to: 'sessions#destroy', as: 'logout'
end
