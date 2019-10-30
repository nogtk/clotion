class Shop < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  has_many :images, dependent: :destroy
end
