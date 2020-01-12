module SalesInfo
  class ImagesFetchService
    def initialize
      @client = TwitterClient.new
    end

    def call
      Shop.all.each do |s|
        images = fetch_images(s.twitter_user_id)
        images.each_with_index do |image, suffix|
          filename = "#{s.id}_#{suffix}"
          SalesInfo::ImageBuilder.new(s, image, filename).build
        end
      end
    end

    private

    def fetch_images(twitter_user_id)
      @client.tweets(twitter_user_id).each_with_object([]) do |tweet, arr|
        if tweet.media.first.nil?
          next
        else
          arr << tweet.media.first.media_url_https.to_s
        end
      end
    end
  end
end