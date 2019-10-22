class SalesDateParser
  def initialize(tweet)
    @tweet = tweet
  end

  def sale_date_from_tweet
    if today?(content)
      tweeted_time
    elsif tomorrow?(content)
      tweeted_time.tomorrow
    else
      get_date_from_content_by_regexp(content) || tweeted_time
    end
  end

  private

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
    match_data = content.match(/\d{4}\/(\d{1,2})\/(\d{1,2})/) || content.match(/(\d{1,2})\/(\d{1,2})/) || content.match(/(\d{1,2})月(\d{1,2})日/)
    if match_data
      begin
        Date.new(Date.current.year, match_data[1].to_i, match_data[2].to_i)
      rescue ArgumentError
        nil
      end
    end
  end

  def tweet_id2tweeted_time(id)
    Time.at(((id.to_i >> 22) + 1288834974657) / 1000.0).to_date
  end

  def content
    @tweet.text
  end

  def tweeted_time
    tweet_id2tweeted_time(@tweet.id)
  end

end
