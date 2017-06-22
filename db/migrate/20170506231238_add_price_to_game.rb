class AddPriceToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :price, :decimal
  end
end
