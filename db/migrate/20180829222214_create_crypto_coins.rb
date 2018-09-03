class CreateCryptoCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :crypto_coins do |t|
      t.string :name
      t.timestamp :timestamp
      t.float :last_price

      t.timestamps
    end
  end
end
