require 'uri'
require 'net/http'
require 'sidekiq-scheduler'
class ReadDataFromApiJob
  include Sidekiq::Worker

  def perform
    puts 'Collecting tickers...'
    Adapters::Bitfinex.save_ticker("btcusd")
    Adapters::Buda.save_ticker("btc-clp")
    Adapters::Bitstamp.save_ticker("btcusd")


  end

end