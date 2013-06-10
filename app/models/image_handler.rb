class ImageHandler < ActiveRecord::Base
  attr_accessible :title, :alt, :image, :remote_image_url, :description,
                  :button_text, :button_url, :link
  has_and_belongs_to_many :pages
  mount_uploader :image, ImageUploader
end
