Rails.application.routes.draw do
  root "manufacturers#index"
  resources :manufacturers, only: [:index, :show, :new, :create]
  resources :cars, only: [:index, :new, :create]
end
