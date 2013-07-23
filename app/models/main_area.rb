class MainArea < ActiveRecord::Base
  has_and_belongs_to_many :sections
  attr_accessible :title, :link, :area_name, :section_ids
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
