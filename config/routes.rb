Rails.application.routes.draw do
  # resources :users
  resources :users, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  resources :sessions, only: [:new, :create, :destroy]
  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
