class Shop < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  has_many_attached :images
end
