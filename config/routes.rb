Rails.application.routes.draw do
  resources :games, only: [:new] do
    member do
      post :switch #After loading, route to switch, where server attempts to switch and block
      get :roll #After attempting to switch, route to roll, where player will roll
      get :results #After rolling, route to results, where player sees score, and is asked to play again (route to start game)
    end
  end
  resources :users, except: :index
  resources :sessions, only: [:new, :create, :destroy]
  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
