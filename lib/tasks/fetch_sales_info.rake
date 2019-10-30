namespace :fetch_sales_info do
  desc "Fetch stores to aggregate by using Twitter API"
  task stores: :environment do
    Shop.destroy_all
    ActiveRecord::Base.connection.execute('ALTER SEQUENCE shops_id_seq RESTART WITH 1')
    client = TwitterClient.new
    client.fetch_shop_from_list.each do |shop|
      s = Shop.new(name: shop.name, url: shop.to_h[:url], twitter_user_id: shop.id, twitter_url: shop.url.to_s, twitter_thumbnail_image_url: shop.profile_image_url_https.to_s)
      s.save!
    end
  end

  desc "test sales date from each store's tweet by using Twitter API"
  task sales_date: :environment do
    SaleInfo.destroy_all
    ActiveRecord::Base.connection.execute('ALTER SEQUENCE sale_infos_id_seq RESTART WITH 1')
    client = SalesInformationClient.new
    Shop.all.each do |s|
      sold_date = client.fetch_sale_dates(s.twitter_user_id)
      SaleInfo.new(shop_id: s.id, sold_at: sold_date).save! if sold_date
    end
  end

  desc "Fetch clothes images from each store's tweet by using Twitter API"
  task images: :environment do
    Image.destroy_all
    ActiveRecord::Base.connection.execute('ALTER SEQUENCE images_id_seq RESTART WITH 1')
    client = SalesInformationClient.new
    Shop.all.each do |s|
      images = client.fetch_images(s.twitter_user_id)
      images.each_with_index do |image, i|
        break if i == 20
        Image.new(shop_id: s.id, image_url: image).save!
      end
    end
  end
end
