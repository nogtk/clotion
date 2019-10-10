class TwitterClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  def sales_info
    fetch_shop_from_list.each_with_object({}) do |shop, hash|
      tweet_contents(shop).each do |content|
        search_words.each do |word|
         if content.include?(word)
           parser = SalesDateParser.new(content)
           hash[shop.name] = parser.sale_date_from_tweet
           break
         end
        end
      end
    end
  end

  private

  def fetch_shop_from_list
    @client.list_members(ENV['TWITTER_AGGREGATE_USER_NAME'], ENV['TWITTER_AGGREGATE_LIST_NAME']).each_with_object([]) do |member, arr|
      arr << member
    end
  end

  def tweet_contents(account)
    @client.user_timeline(account, opt).each_with_object([]) do |tweet, arr|
      arr << tweet.text
    end
  end

  def search_words
    %w(発売 公開 入荷 update arrival arrivals)
  end

  def opt
    { count: 10, exclude_replies: true, retweeted: false }
  end
end