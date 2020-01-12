module SalesInfo
  class DateFetchService
    def initialize
      @client = TwitterClient.new
    end

    def call
      Shop.all.each do |s|
        date = fetch_date(s.twitter_user_id)
        SalesInfo::DateBuilder.new(s, date).build if date.present?
      end
    end

    private

    def fetch_date(twitter_user_id)
      @client.tweets(twitter_user_id).each do |tweet|
        if have_keywords?(tweet.to_h[:full_text])
          return extract_date(tweet)
        end
      end
    end

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
end