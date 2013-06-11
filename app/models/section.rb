class Section < ActiveRecord::Base
  has_and_belongs_to_many :pages
  attr_accessible :title, :link, :location, :ordinal

  scope :bottom, where(:location => "bottom")
  scope :products, where(:location => "products")
  scope :drinks, where(:location => "drinks")
  scope :contact, where(:location => "contact")
  scope :events, where(:location => "events")
end
