module Adapters
  class Bitstamp
    class << self
      def save_ticker(coin)
        data = read_from_api(coin)
        save(data)
      end
      def read_from_api(coin)
        url = URI("https://www.bitstamp.net/api/v2/ticker/#{coin}/")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        response = http.request(request)
        JSON.parse(response.body)
      end

      def save(data)
        puts data
        name = "btcusd"
        last_price = data['last']
        timestamp = Time.at(data['timestamp'].to_f)

        puts timestamp
        @crypto = CryptoCoin.new
        @crypto.name = name
        @crypto.last_price = last_price
        @crypto.timestamp = timestamp
        @crypto.market = "BS"
        @crypto.save
      end
    end
  end
end