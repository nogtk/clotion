module SalesInfo
  class DateBuilder
    def initialize(shop, date)
      @shop = shop
      @date = date
    end

    def build
      SaleInfo.new(shop_id: @shop.id, sold_at: @date).save!
    end
  end
end