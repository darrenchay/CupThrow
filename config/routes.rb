Rails.application.routes.draw do
  get 'game/new'
  get 'game/start'
  post 'game/load', to: 'game#load'
  get 'game/switch'
  get 'game/block'
  get 'game/throw'
  resources :users, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  resources :sessions, only: [:new, :create, :destroy]
  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
