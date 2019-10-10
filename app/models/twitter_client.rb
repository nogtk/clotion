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
    shop_list = timeline_members
    sales_info =
      shop_list.each_with_object({}) do |shop, hash|
        timeline_each_user(shop).each do |content|
          search_words.each do |word|
           if content.include?(word)
             hash[shop.name] = parse_sale_date(content)
             break
           end
          end
        end
      end
  end

  private

  def timeline_members
    list_members = @client.list_members(ENV['TWITTER_AGGREGATE_USER_NAME'], ENV['TWITTER_AGGREGATE_LIST_NAME']).each_with_object([]) do |member, arr|
      arr << member
    end
  end

  def timeline_each_user(target)
    tweet_text = @client.user_timeline(target, opt).each_with_object([]) do |tweet, arr|
      arr << tweet.text
    end
  end

  def parse_sale_date(content)
    if today?(content)
      Date.current
    elsif tomorrow?(content)
      Date.current + 1.days
    else
      get_date_from_content_by_regexp(content) || Date.current
    end
  end

  def today?(content)
    today_words.each do |word|
      if content.match(word)
        return true
      end
    end
    false
  end

  def today_words
    [/today/i, /now/i, "本日"]
  end

  def tomorrow?(content)
    tomorrow_words.each do |word|
      if content.match(word)
        return true
      end
    end
    false
  end

  def tomorrow_words
    [/tomorrow/i, "明日"]
  end

  def get_date_from_content_by_regexp(content)
    match_data = content.match(/(\d{1, 2})\/(\d{1, 2})/) || content.match(/(\d{1, 2})月(\d{1, 2})日/)
    if match_data
      Date.new(Date.current.year, match_data[1].to_i, match_data[2].to_i)
    end
  end

  def search_words
    %w(発売 公開 入荷 update arrival arrivals)
  end

  def opt
    { count: 10, exclude_replies: true, retweeted: false }
  end
end