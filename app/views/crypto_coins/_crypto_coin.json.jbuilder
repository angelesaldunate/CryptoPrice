json.extract! crypto_coin, :id, :name, :timestamp, :last_price, :created_at, :updated_at
json.url crypto_coin_url(crypto_coin, format: :json)
