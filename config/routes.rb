Rails.application.routes.draw do

  devise_for :users
  root to: 'spaceships#index'

  resources :users do
    get "dashboard", to: "users#myspaceships"
    resources :spaceships, only: [:index, :new, :edit, :show, :create, :update, :destroy] do
      resources :reviews
      resources :bookings, only: [:index, :new, :edit, :create]
    end
    resources :bookings, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
