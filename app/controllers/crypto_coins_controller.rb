class CryptoCoinsController < ApplicationController

  before_action :set_crypto_coin, only: [:show, :edit, :update, :destroy]

  # GET /crypto_coins
  # GET /crypto_coins.json
  def index
    @crypto_coins = CryptoCoin.all
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
