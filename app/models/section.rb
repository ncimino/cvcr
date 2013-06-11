class Section < ActiveRecord::Base
  has_and_belongs_to_many :pages
  attr_accessible :title, :link, :location, :ordinal

  scope :bottom, where(:location => "bottom")
end
