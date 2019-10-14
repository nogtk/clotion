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
end
