class ImageHandler < ActiveRecord::Base
  has_and_belongs_to_many :pages
  has_and_belongs_to_many :products
  attr_accessible :title, :alt, :image, :remote_image_url, :description,
                  :button_text, :button_url, :link
  validates_presence_of :alt
  mount_uploader :image, ImageUploader
end
