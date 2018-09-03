require 'uri'
require 'net/http'
require 'sidekiq-scheduler'
class ReadDataFromApiJob
  include Sidekiq::Worker

  def perform
    puts 'Collecting tickers...'
    Adapters::Bitfinex.save_ticker
    Adapters::Buda.save_ticker
    Adapters::Bitstamp.save_ticker
    data = read_from_api
    save(data)

  end

  def read_from_api
    url = URI("https://api.bitfinex.com/v1/pubticker/btcusd")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    JSON.parse(response.body)
  end

  def save(data)
    puts data
    name = "btcusd"
    last_price = data['last_price']
    timestamp = Time.at(data['timestamp'].to_f)
    puts timestamp
    @crypto = CryptoCoin.new
    @crypto.name = name
    @crypto.last_price = last_price
    @crypto.timestamp = timestamp
    @crypto.save
  end
end