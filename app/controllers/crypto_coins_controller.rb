class CryptoCoinsController < ApplicationController
  require 'data_manager'

  before_action :set_crypto_coin, only: [:show, :edit, :update, :destroy]

  # GET /crypto_coins
  # GET /crypto_coins.json
  def index
    @crypto_coins = CryptoCoin.all
  end
  def home
    dm = DataManager.new
    @timestamps_bitfinex_nr = dm.get_last_btc_time_bitfinex("btcusd")
    @timestamps_bitfinex = dm.get_last_btc_time_bitfinex("btcusd").reverse
    @prices_bitfinex = dm.get_last_btc_price_bitfinex("btcusd")
    @prices_bitstamp = dm.get_last_btc_price_bitstamp("btcusd")
    @prices_buda = dm.get_last_btc_price_buda("btc-clp")
    sub = dm.substracted(@prices_bitfinex,@prices_buda,@prices_bitstamp)
    @last_prices_bitfinex_nr = sub[:x]
    @last_prices_buda_nr = sub[:y]
    @last_prices_bitstamp_nr = sub[:z]

    @last_prices_bitfinex = sub[:x].reverse
    @last_prices_buda = sub[:y].reverse
    @last_prices_bitstamp = sub[:z].reverse
    daily = dm.latest_day_hour("btcusd", "btc-clp")
    @day_bitfinex = daily[:x]
    @day_buda = daily[:y]
    @day_bitstamp = daily[:z]
    @day_timestamps = daily[:times]

  end
  def ltc
    dm = DataManager.new
    @timestamps_bitfinex_nr = dm.get_last_btc_time_bitfinex("ltcusd")
    @timestamps_bitfinex = dm.get_last_btc_time_bitfinex("ltcusd").reverse
    @prices_bitfinex = dm.get_last_btc_price_bitfinex("ltcusd")
    @prices_bitstamp = dm.get_last_btc_price_bitstamp("ltcusd")
    @prices_buda = dm.get_last_btc_price_buda("ltc-clp")
    sub = dm.substracted(@prices_bitfinex,@prices_buda,@prices_bitstamp)
    @last_prices_bitfinex_nr = sub[:x]
    @last_prices_buda_nr = sub[:y]
    @last_prices_bitstamp_nr = sub[:z]

    @last_prices_bitfinex = sub[:x].reverse
    @last_prices_buda = sub[:y].reverse
    @last_prices_bitstamp = sub[:z].reverse
    daily = dm.latest_day_hour("ltcusd", "ltc-clp")
    @day_bitfinex = daily[:x]
    @day_buda = daily[:y]
    @day_bitstamp = daily[:z]
    @day_timestamps = daily[:times]
  end
  def eth
    dm = DataManager.new
    @timestamps_bitfinex_nr = dm.get_last_btc_time_bitfinex("ethusd")
    @timestamps_bitfinex = dm.get_last_btc_time_bitfinex("ethusd").reverse
    @prices_bitfinex = dm.get_last_btc_price_bitfinex("ethusd")
    @prices_bitstamp = dm.get_last_btc_price_bitstamp("ethusd")
    @prices_buda = dm.get_last_btc_price_buda("eth-clp")
    sub = dm.substracted(@prices_bitfinex,@prices_buda,@prices_bitstamp)
    @last_prices_bitfinex_nr = sub[:x]
    @last_prices_buda_nr = sub[:y]
    @last_prices_bitstamp_nr = sub[:z]

    @last_prices_bitfinex = sub[:x].reverse
    @last_prices_buda = sub[:y].reverse
    @last_prices_bitstamp = sub[:z].reverse
    daily = dm.latest_day_hour("ethusd", "eth-clp")
    @day_bitfinex = daily[:x]
    @day_buda = daily[:y]
    @day_bitstamp = daily[:z]
    @day_timestamps = daily[:times]
  end
  def bch
    dm = DataManager.new
    @timestamps_bitfinex_nr = dm.get_last_btc_time_bitfinex("bchusd")
    @timestamps_bitfinex = dm.get_last_btc_time_bitfinex("bchusd").reverse
    @prices_bitfinex = dm.get_last_btc_price_bitfinex("bchusd")
    @prices_bitstamp = dm.get_last_btc_price_bitstamp("bchusd")
    @prices_buda = dm.get_last_btc_price_buda("bch-clp")
    sub = dm.substracted(@prices_bitfinex,@prices_buda,@prices_bitstamp)
    @last_prices_bitfinex_nr = sub[:x]
    @last_prices_buda_nr = sub[:y]
    @last_prices_bitstamp_nr = sub[:z]

    @last_prices_bitfinex = sub[:x].reverse
    @last_prices_buda = sub[:y].reverse
    @last_prices_bitstamp = sub[:z].reverse
    daily = dm.latest_day_hour("bchusd", "bch-clp")
    @day_bitfinex = daily[:x]
    @day_buda = daily[:y]
    @day_bitstamp = daily[:z]
    @day_timestamps = daily[:times]
  end
  # GET /crypto_coins/1
  # GET /crypto_coins/1.json
  def show
  end

  # GET /crypto_coins/new
  def new
    @crypto_coin = CryptoCoin.new
=begin
    rd = ::ReadDataFromApiJob.new
    data = rd.read_from_api
    rd.save(data)
=end
  end

  # GET /crypto_coins/1/edit
  def edit
  end

  # POST /crypto_coins
  # POST /crypto_coins.json
  def create
    @crypto_coin = CryptoCoin.new(crypto_coin_params)

    respond_to do |format|
      if @crypto_coin.save
        format.html { redirect_to @crypto_coin, notice: 'Crypto coin was successfully created.' }
        format.json { render :show, status: :created, location: @crypto_coin }
      else
        format.html { render :new }
        format.json { render json: @crypto_coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crypto_coins/1
  # PATCH/PUT /crypto_coins/1.json
  def update
    respond_to do |format|
      if @crypto_coin.update(crypto_coin_params)
        format.html { redirect_to @crypto_coin, notice: 'Crypto coin was successfully updated.' }
        format.json { render :show, status: :ok, location: @crypto_coin }
      else
        format.html { render :edit }
        format.json { render json: @crypto_coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crypto_coins/1
  # DELETE /crypto_coins/1.json
  def destroy
    @crypto_coin.destroy
    respond_to do |format|
      format.html { redirect_to crypto_coins_url, notice: 'Crypto coin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crypto_coin
      @crypto_coin = CryptoCoin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crypto_coin_params
      params.require(:crypto_coin).permit(:name, :timestamp, :last_price)
    end
end
