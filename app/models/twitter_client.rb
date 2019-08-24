class TwitterClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  def timeline_members
    list_members = []
    @client.list_members(ENV['TWITTER_AGGREGATE_USER_NAME'], ENV['TWITTER_AGGREGATE_LIST_NAME']).each do |member|
      list_members << member
    end
    list_members
  end

  def timeline_each_user(target)
    tweet_text = []
    @client.user_timeline(target).each do |tweet|
      tweet_text << tweet.text
    end
    tweet_text
  end
end