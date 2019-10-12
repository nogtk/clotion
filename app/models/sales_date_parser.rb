class SalesDateParser
  def initialize(tweet)
    @tweet = tweet
  end

  def sale_date_from_tweet
    if today?(content)
      Date.current
    elsif tomorrow?(content)
      Date.current + 1.days
    else
      get_date_from_content_by_regexp(content) || Date.current
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
    match_data = content.match(/(\d{1, 2})\/(\d{1, 2})/) || content.match(/(\d{1, 2})月(\d{1, 2})日/)
    if match_data
      Date.new(Date.current.year, match_data[1].to_i, match_data[2].to_i)
    end
  end

  def content
    @tweet.text
  end
end