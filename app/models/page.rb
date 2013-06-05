class Page < ActiveRecord::Base

  validates_presence_of :name, :location

  scope :topbar, where(:location => "topbar")
  scope :bottombar, where(:location => "bottombar")

  def to_param
    "#{id}-#{name.parameterize}"
  end

  attr_accessible :content, :location, :name, :ordinal, :title, :url
end
