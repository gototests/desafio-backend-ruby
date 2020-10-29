Rails.application.routes.draw do
  resources :products, only: [:create, :update, :show, :destroy]
  resources :stores, only: [:create, :update, :show, :destroy]
end
