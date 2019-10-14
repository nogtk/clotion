class SalesInformationClient
  def initialize
    @client = TwitterClient.new
  end

  def sales_info
    @client.fetch_shop_from_list.each_with_object({}) do |shop, hash|
      @client.tweets(shop).each do |tweet|
        if have_keywords?(tweet.text)
          hash[shop.name] = extract_date(tweet)
          break
        end
      end
    end
  end

  private

  def have_keywords?(content)
    search_keywords.each do |word|
      return true if content.include?(word)
    end
    false
  end

  def search_keywords
    %w(発売 公開 入荷 update arrival arrivals)
  end

  def extract_date(tweet)
    SalesDateParser.new(tweet).sale_date_from_tweet
  end
end
