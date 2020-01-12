require 'open-uri'

module SalesInfo
  class ImageBuilder
    def initialize(shop, image, filename)
      @shop = shop
      @image = image
      @filename = filename
    end

    def build
      io = open(@image)
      @shop.images.attach(io: io, filename: @filename)
    end
  end
end