class Page < ActiveRecord::Base
  #serialize :images

  attr_accessible :content, :location, :name, :ordinal, :title, :url
  #, :images
  validates_presence_of :name, :location

  scope :topbar, where(:location => "topbar")
  scope :bottombar, where(:location => "bottombar")

  #mount_uploader :images, ImageUploader

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
