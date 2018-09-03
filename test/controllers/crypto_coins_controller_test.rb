require 'test_helper'

class CryptoCoinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crypto_coin = crypto_coins(:one)
  end

  test "should get index" do
    get crypto_coins_url
    assert_response :success
  end

  test "should get new" do
    get new_crypto_coin_url
    assert_response :success
  end

  test "should create crypto_coin" do
    assert_difference('CryptoCoin.count') do
      post crypto_coins_url, params: { crypto_coin: { last_price: @crypto_coin.last_price, name: @crypto_coin.name, timestamp: @crypto_coin.timestamp } }
    end

    assert_redirected_to crypto_coin_url(CryptoCoin.last)
  end

  test "should show crypto_coin" do
    get crypto_coin_url(@crypto_coin)
    assert_response :success
  end

  test "should get edit" do
    get edit_crypto_coin_url(@crypto_coin)
    assert_response :success
  end

  test "should update crypto_coin" do
    patch crypto_coin_url(@crypto_coin), params: { crypto_coin: { last_price: @crypto_coin.last_price, name: @crypto_coin.name, timestamp: @crypto_coin.timestamp } }
    assert_redirected_to crypto_coin_url(@crypto_coin)
  end

  test "should destroy crypto_coin" do
    assert_difference('CryptoCoin.count', -1) do
      delete crypto_coin_url(@crypto_coin)
    end

    assert_redirected_to crypto_coins_url
  end
end
