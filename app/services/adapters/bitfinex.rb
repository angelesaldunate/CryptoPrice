module Adapters
  class Bitfinex
    class << self
      def save_ticker(coin)
        data = read_from_api(coin)
        save(data,coin)
      end
      def read_from_api(coin)
        url = URI("https://api.bitfinex.com/v1/pubticker/#{coin}")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        response = http.request(request)
        JSON.parse(response.body)
      end

      def save(data,coin)
        puts data
        name = coin
        last_price = data['last_price']
        timestamp = Time.at(data['timestamp'].to_f)

        puts timestamp
        @crypto = CryptoCoin.new
        @crypto.name = name
        @crypto.last_price = last_price
        @crypto.timestamp = timestamp
        @crypto.market = "BF"
        @crypto.save
      end
    end
  end
end