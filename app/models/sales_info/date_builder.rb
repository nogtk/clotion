module SalesInfo
  class DateBuilder
    def initialize(date)
      @date = date
    end

    def build
      SaleInfo.new(shop_id: s.id, sold_at: date).save!
    end
  end
end