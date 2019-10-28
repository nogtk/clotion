Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'twitter_clients#index'
  resources :twitter_clients, only: [:index]
  resources :about, only: [:index]
end
