class Section < ActiveRecord::Base
  has_and_belongs_to_many :pages
  has_and_belongs_to_many :products
  has_and_belongs_to_many :main_areas
  attr_accessible :title, :link, :location, :ordinal, :main_area_ids
  scope :bottom, where(:location => "bottom")
  scope :products, where(:location => "products")
  scope :drinks, where(:location => "drinks")
  scope :contact, where(:location => "contact")
  scope :events, where(:location => "events")
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
