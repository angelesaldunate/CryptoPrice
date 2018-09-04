class DataManager
  def get_last_btc_price_bitfinex
    @data_from_database = CryptoCoin.all.select(:last_price).where(market: "BF").order(id: :desc ).limit(30)
    @last_prices_bitfinex = @data_from_database.map(&:last_price)
  end
  def get_last_btc_time_bitfinex
    @timestamp_from_database = CryptoCoin.all.select(:timestamp).where(market: "BF").order(id: :desc ).limit(30)
    @timestamps_bitfinex = @timestamp_from_database.map(&:timestamp)
    @timestamps_bitfinex.map! {|item| item.strftime("%H:%M:%S")}
  end
  def get_last_btc_price_bitstamp
    @data_from_database = CryptoCoin.all.select(:last_price).where(market: "BS").order(id: :desc ).limit(30)
    @last_prices_bitfinex = @data_from_database.map(&:last_price)
  end
  def get_last_btc_time_bitstamp
    @timestamp_from_database = CryptoCoin.all.select(:timestamp).where(market: "BS").order(id: :desc ).limit(30)
    @timestamps_bitstamp = @timestamp_from_database.map(&:timestamp)
  end
  def get_last_btc_price_buda
    @data_from_database = CryptoCoin.all.select(:last_price).where(market: "BD").order(id: :desc ).limit(30)
    @last_prices_buda = @data_from_database.map(&:last_price)
  end
  def get_last_btc_time_buda
    @timestamp_from_database = CryptoCoin.all.select(:timestamp).where(market: "BD").order(id: :desc ).limit(30)
    @timestamps_bitfinex = @timestamp_from_database.map(&:timestamp)
  end
  def substracted(one,two,three)
    @bitfinex = []
    @buda = []
    @bitstamp = []

    for i in 0..one.size-1
      if one[i]!= nil && two[i]!=nil && three[i]!=nil
      if one[i] < two[i] && one[i]< three[i]
        @bitfinex.push(0)
        @buda.push(two[i] - one[i])
        @bitstamp.push(three[i] - one[i])
      end
      if two[i] < one[i] && two[i]< three[i]
        @buda.push(0)
        @bitfinex.push(one[i] - two[i])
        @bitstamp.push(three[i] - two[i])
      end
      if three[i]<one[i] and three[i] < two[i]
        @bitstamp.push(0)
        @bitfinex.push(one[i] - three[i])
        @buda.push(two[i] - three[i])
      end
      end
    end
    {:x => @bitfinex, :y => @buda, :z =>@bitstamp}
  end
  def latest_day_hour
    now = Time.now
    one_day = Time.now-1.day
    cr = CryptoCoin.select(:last_price).where("timestamp BETWEEN ? AND ?",one_day, now )
    times = CryptoCoin.select(:timestamp).where("timestamp BETWEEN ? AND ?",one_day, now )
    times = times.where(market: "BS").map(&:timestamp)
    times.map! {|item| item.strftime("%H:%M:%S")}
    puts(times)
    crbs = cr.where(market: "BS").map(&:last_price)
    crbd = cr.where(market: "BD").map(&:last_price)
    crbf = cr.where(market: "BF").map(&:last_price)
    {:x => crbf, :y => crbd, :z => crbs, :times =>times}
  end

end

