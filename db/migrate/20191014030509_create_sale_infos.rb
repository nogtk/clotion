class CreateSaleInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_infos do |t|
      t.belongs_to :shop
      t.datetime :sold_at

      t.timestamps
    end
  end
end
