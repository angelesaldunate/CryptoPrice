require "application_system_test_case"

class CryptoCoinsTest < ApplicationSystemTestCase
  setup do
    @crypto_coin = crypto_coins(:one)
  end

  test "visiting the index" do
    visit crypto_coins_url
    assert_selector "h1", text: "Crypto Coins"
  end

  test "creating a Crypto coin" do
    visit crypto_coins_url
    click_on "New Crypto Coin"

    fill_in "Last Price", with: @crypto_coin.last_price
    fill_in "Name", with: @crypto_coin.name
    fill_in "Timestamp", with: @crypto_coin.timestamp
    click_on "Create Crypto coin"

    assert_text "Crypto coin was successfully created"
    click_on "Back"
  end

  test "updating a Crypto coin" do
    visit crypto_coins_url
    click_on "Edit", match: :first

    fill_in "Last Price", with: @crypto_coin.last_price
    fill_in "Name", with: @crypto_coin.name
    fill_in "Timestamp", with: @crypto_coin.timestamp
    click_on "Update Crypto coin"

    assert_text "Crypto coin was successfully updated"
    click_on "Back"
  end

  test "destroying a Crypto coin" do
    visit crypto_coins_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Crypto coin was successfully destroyed"
  end
end
