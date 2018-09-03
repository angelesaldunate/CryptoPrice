Rails.application.routes.draw do
  resources :crypto_coins
  root to: 'crypto_coins#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
