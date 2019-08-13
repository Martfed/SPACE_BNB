Rails.application.routes.draw do

  devise_for :users
  root to: 'spaceships#index'

  resources :users do
    resources :spaceships, only: [:index, :new, :edit, :show, :destroy] do
      resources :reviews
      resources :bookings, only: [:index, :new, :edit]
    end
    resources :bookings, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
