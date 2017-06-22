class DropImgLogoUrlFromGame < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :img_logo_url
  end
end
