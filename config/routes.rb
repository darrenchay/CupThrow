Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: :index
  
  resources :games, only: [:new, :create]
  get 'games/:id/switch' => 'games#switch', as: :switch
  match 'games/:id/roll' => 'games#roll', as: :roll, via: [:get, :post]
  get 'games/:id/results' => 'games#results', as: :results
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
