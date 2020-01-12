module SalesInfo
  class ShopFetchService
    def initialize
      @client = TwitterClient.new
    end

    def call
      accounts = @client.fetch_shop_from_list

      accounts.each do |account|
        @shop_builder = SalesInfo::ShopBuilder.new(account)
        shop = @shop_builder.build
        shop.save!
      end
    end
  end
end