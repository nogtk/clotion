class Image < ApplicationRecord
  belongs_to :shop
  validates :image_url, presence: true
end
