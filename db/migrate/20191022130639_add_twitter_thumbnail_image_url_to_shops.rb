class AddTwitterThumbnailImageUrlToShops < ActiveRecord::Migration[5.2]
  def change
   add_column :shops, :twitter_thumbnail_image_url, :string
    change_column_null :shops, :twitter_thumbnail_image_url, null: false
  end
end
