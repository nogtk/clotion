class Shop < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  has_many_attached :images

  def delete_all_images
    self.images.each { |image| image.purge }
  end
end
