class DataManager
  def get_last_btc_price_bitfinex(coin)
    @data_from_database = CryptoCoin.all.select(:last_price).where(market: "BF", name: coin).order(id: :desc ).limit(30)
    @last_prices_bitfinex = @data_from_database.map(&:last_price)
  end
  def get_last_btc_time_bitfinex(coin)
    @timestamp_from_database = CryptoCoin.all.select(:timestamp).where(market: "BF", name: coin).order(id: :desc ).limit(30)
    @timestamps_bitfinex = @timestamp_from_database.map(&:timestamp)
    @timestamps_bitfinex.map! {|item| item.strftime("%H:%M:%S")}
  end
  def get_last_btc_price_bitstamp(coin)
    @data_from_database = CryptoCoin.all.select(:last_price).where(market: "BS", name: coin).order(id: :desc ).limit(30)
    @last_prices_bitfinex = @data_from_database.map(&:last_price)
  end
  def get_last_btc_time_bitstamp(coin)
    @timestamp_from_database = CryptoCoin.all.select(:timestamp).where(market: "BS", name: coin).order(id: :desc ).limit(30)
    @timestamps_bitstamp = @timestamp_from_database.map(&:timestamp)
  end
  def get_last_btc_price_buda(coin)
    @data_from_database = CryptoCoin.all.select(:last_price).where(market: "BD", name: coin ).order(id: :desc ).limit(30)
    @last_prices_buda = @data_from_database.map(&:last_price)
  end
  def get_last_btc_time_buda(name)
    @timestamp_from_database = CryptoCoin.all.select(:timestamp).where(market: "BD", name: coin).order(id: :desc ).limit(30)
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
  def latest_day_hour(coin, coinbuda)
    now = Time.now
    one_day = Time.now-1.day
    cr = CryptoCoin.select(:last_price).where("timestamp BETWEEN ? AND ?",one_day, now )
    times = CryptoCoin.select(:timestamp).where("timestamp BETWEEN ? AND ?",one_day, now )
    times = times.where(market: "BS", name: coin).or(times.where(market: "BS", name: coinbuda)).map(&:timestamp)
    filtered_time = []
    count = 0
    times.each do |item|
        if count%60 ==0
          filtered_time.push(item)
        end
      count+=1
    end
    filtered_time.map! {|item| item.strftime("%H:%M:%S")}
    crbs = cr.where(market: "BS", name: coin).map(&:last_price)
    crbd = cr.where(market: "BD", name: coinbuda).map(&:last_price)
    crbf = cr.where(market: "BF", name: coin).map(&:last_price)

    final_crbs = []
    count = 0
    crbs.each do |item|
      if count%60 ==0
        final_crbs.push(item)
      end
      count+=1
    end

    final_crbd = []
    count = 0
    crbd.each do |item|
      if count%60 ==0
        final_crbd.push(item)
      end
      count+=1
    end
    final_crbf = []
    count = 0
    crbf.each do |item|
      if count%60 ==0
        final_crbf.push(item)
      end
      count+=1
    end

    {:x => final_crbf, :y => final_crbd, :z => final_crbs, :times =>filtered_time}
  end

  def oscilator(values)
    k = []
    s = []
    mini = values.min
    maxi = values.max
    values.each do |i|
      k.push((i-mini)/(maxi-mini)*100)
    end
    (5..k.size+4).each do |i|
      s.push(k[i-5..i].inject(:+)/5)
    end
    media = []
    sold = []
    buy = []
    values.each do |i|
      media.push((k.max+k.min)/2)
      sold.push((k.max+k.min)/2*80/50)
      buy.push((k.max+k.min)/2*20/50)
    end

    todo = ""
    if values[-1]>= sold[-1]
      todo = "SELL"
    elsif values[-1]<= buy[-1]
      todo = "BUY"
    else
      todo = "WAIT"
    end



    {:k => k, :s => s, :media =>media, :sold=>sold, :buy=>buy, :todo => todo}
  end

end

