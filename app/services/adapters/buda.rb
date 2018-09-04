module Adapters
  class Buda
    class << self
      def save_ticker(coin)
        data = read_from_api(coin)
        save(data)
      end
      def read_from_api(coin)
        url = URI("https://www.buda.com/api/v2/markets/#{coin}/ticker")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        response = http.request(request)
        JSON.parse(response.body)
      end

      def save(data)
        puts data
        name = "btcusd"
        last_price = data['ticker']['last_price'][0]
        timestamp = Time.now

        puts timestamp
        @crypto = CryptoCoin.new
        @crypto.name = name
        @crypto.last_price = (last_price.to_f / 695.0)
        @crypto.timestamp = timestamp
        @crypto.market = "BD"
        @crypto.save
      end
    end
  end
end