namespace :fetch_sales_info do
  desc "Fetch stores to aggregate by using Twitter API"
  task fetch_stores: :environment do
    Shop.destroy_all
    client = TwitterClient.new
    client.fetch_shop_from_list.each do |shop|
      s = Shop.new(name: shop.name, url: shop.to_h[:url], twitter_user_id: shop.id)
      s.save!
    end
  end

  desc "test sales date from each store's tweet by using Twitter API"
  task fetch_sales_date: :environment do
    client = SalesInformationClient.new
    Shop.all.each do |s|
      sold_date = client.fetch_sale_dates(s.twitter_user_id)
      SaleInfo.new(shop_id: s.id, sold_at: sold_date).save! if sold_date
    end
  end
end
