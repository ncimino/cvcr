class Page < ActiveRecord::Base
  has_and_belongs_to_many :image_handlers
  has_and_belongs_to_many :sections

  #after_update :save_images
  attr_accessible :content, :location, :name, :ordinal, :title, :url,
                  :image_handler_ids, :section_ids
  validates_presence_of :name, :location

  scope :topbar, where(:location => "topbar")
  #scope :link1, where(:location => "topbar")
  #scope :link2, where(:location => "topbar")
  #scope :link3, where(:location => "topbar")
  #scope :link4, where(:location => "topbar")
  scope :bottombar, where(:location => "bottombar")


  def to_param
    "#{id}-#{name.parameterize}"
  end

  #def new_image_attributes=(image_attributes)
  #  image_attributes.each do |attributes|
  #    image_handlers.build(attributes)
  #  end
  #end
  #
  #def existing_image_attributes=(image_attributes)
  #  image_handlers.reject(&:new_record?).each do |image_handler|
  #    attributes = image_attributes[image_handlers.id.to_s]
  #    if attributes
  #      image_handler.attributes = attributes
  #    else
  #      image_handlers.delete(image_handler)
  #    end
  #  end
  #end
  #
  #def save_images
  #  image_handlers.each do |image_handler|
  #    image_handler.save(false)
  #  end
  #end
  #
  #def image_selector
  #  images = :image_handlers.map do |c|
  #    [c, c.id, {:data-img-src => c.image}]
  #  end
  #
  #  return options_for_select(images)
  #end

end
