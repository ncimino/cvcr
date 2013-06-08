class ImageHandler < ActiveRecord::Base
  attr_accessible :title, :alt, :image, :remote_image_url
  mount_uploader :image, ImageUploader
end
