class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user
      t.integer :count

      t.timestamps
    end
  end
end
