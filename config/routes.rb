Rails.application.routes.draw do
  resources :crypto_coins
  root to: 'crypto_coins#home'
  get 'ltc', to: 'crypto_coins#ltc'
  get 'eth', to: 'crypto_coins#eth'
  get 'bch', to: 'crypto_coins#bch'
  get 'statsbtc', to: 'crypto_coins#statsbtc'
  get 'statsltc', to: 'crypto_coins#statsltc'
  get 'statseth', to: 'crypto_coins#statseth'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
