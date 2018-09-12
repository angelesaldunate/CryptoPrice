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
    t4 = Thread.new do Adapters::Bitfinex.save_ticker("ltcusd")
    end
    t5 = Thread.new do Adapters::Buda.save_ticker("ltc-clp")
    end
    t6 = Thread.new do Adapters::Bitstamp.save_ticker("ltcusd")
    end
    t7 = Thread.new do Adapters::Bitfinex.save_ticker("ethusd")
    end
    t8 = Thread.new do Adapters::Buda.save_ticker("eth-clp")
    end
    t9 = Thread.new do Adapters::Bitstamp.save_ticker("ethusd")
    end
    t10 = Thread.new do Adapters::Bitfinex.save_ticker("bchusd")
    end
    t11 = Thread.new do Adapters::Buda.save_ticker("bch-clp")
    end
    t12 = Thread.new do Adapters::Bitstamp.save_ticker("bchusd")
    end
    t1.join(0.20)
    t2.join(0.20)
    t3.join(0.20)
    t4.join(0.20)
    t5.join(0.20)
    t6.join(0.20)
    t7.join(0.20)
    t8.join(0.20)
    t9.join(0.20)
    t10.join(0.20)
    t11.join(0.20)
    t12.join(0.20)



  end

end