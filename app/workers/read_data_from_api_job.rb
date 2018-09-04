require 'uri'
require 'net/http'
require 'sidekiq-scheduler'
class ReadDataFromApiJob
  include Sidekiq::Worker

  def perform
    puts 'Collecting tickers...'
    t1 = Thread.new do Adapters::Bitfinex.save_ticker("btcusd")
    end
    t2 = Thread.new do Adapters::Buda.save_ticker("btc-clp")
    end
    t3 = Thread.new do Adapters::Bitstamp.save_ticker("btcusd")
    end



  end

end