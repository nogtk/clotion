module SalesInfo
  class ShopBuilder
    def initialize(account)
      @account = account
    end

    def build
      Shop.new(name: @account.name, url: @account.to_h[:url], twitter_user_id: @account.id, twitter_url: @account.url.to_s, twitter_thumbnail_image_url: @account.profile_image_url_https.to_s)
    end
  end
end