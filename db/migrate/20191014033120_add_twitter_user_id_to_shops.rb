class AddTwitterUserIdToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :twitter_user_id, :bigint, null: false
  end
end
