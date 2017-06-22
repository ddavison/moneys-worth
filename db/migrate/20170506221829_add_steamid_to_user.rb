class AddSteamidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :steamid, :string
  end
end
