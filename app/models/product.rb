class Product < ActiveRecord::Base
  has_and_belongs_to_many :image_handlers
  has_and_belongs_to_many :sections
  attr_accessible :description, :image, :name, :price, :section_ids, :image_handler_ids, :active, :content, :supports_grind
  validates_presence_of :name, :price
  def to_param
    "#{id}-#{name.parameterize}"
  end
  scope :recent, find(:all, :order => "updated_at")
end
