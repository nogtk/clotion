class AddTwitterUrlToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :twitter_url, :string
    change_column_null :shops, :twitter_url, null: false
  end
end
