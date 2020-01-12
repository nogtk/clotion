require 'open-uri'

namespace :fetch_sales_info do
  desc "Fetch stores to aggregate by using Twitter API"
  task stores: :environment do
    Shop.all.each { |s| s.delete_all_images }
    Shop.destroy_all
    ActiveRecord::Base.connection.execute('ALTER SEQUENCE shops_id_seq RESTART WITH 1')
    SalesInfo::ShopFetchService.new.call
  end

  desc "test sales date from each store's tweet by using Twitter API"
  task sales_date: :environment do
    SaleInfo.destroy_all
    ActiveRecord::Base.connection.execute('ALTER SEQUENCE sale_infos_id_seq RESTART WITH 1')
    SalesInfo::DateFetchService.new.call
  end

  desc "Fetch clothes images from each store's tweet by using Twitter API"
  task images: :environment do
    Shop.all.each do |s|
      s.images.each do |i|
        i.purge
      end
    end
    client = SalesInformationClient.new
    Shop.all.each do |s|
      images = client.fetch_images(s.twitter_user_id)
      images.each_with_index do |image, i|
        io = open(image)
        s.images.attach(io: io, filename: "#{s.id}_#{i}")
      end
    end
  end
end
