class Parameter < ActiveRecord::Base
  attr_accessible :key, :value
  validates :key, :uniqueness => true
end
