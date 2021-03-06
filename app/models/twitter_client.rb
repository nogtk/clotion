class TwitterClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  def fetch_shop_from_list
    @client.list_members(ENV['TWITTER_AGGREGATE_USER_NAME'], ENV['TWITTER_AGGREGATE_LIST_NAME']).each_with_object([]) do |member, arr|
      arr << member
    end
  end

  def tweets(account)
    @client.user_timeline(account, opt).each_with_object([]) do |tweet, arr|
      next if tweet.text.include?("RT")
      arr << tweet
    end
  end

  private

  def opt
    { count: 20, tweet_mode: 'extended' }
  end
end