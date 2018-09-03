class AddMarketToCryptoCoin < ActiveRecord::Migration[5.2]
  def change
    add_column :crypto_coins, :market, :string
  end
end
