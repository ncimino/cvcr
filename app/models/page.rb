class Page < ActiveRecord::Base
  has_and_belongs_to_many :image_handlers
  has_and_belongs_to_many :sections

  attr_accessible :content, :name, :ordinal, :title, :url,
                  :image_handler_ids, :section_ids
  validates_presence_of :name

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
