class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  attr_accessible :cart, :product, :quantity, :unit_price, :grind

  def full_price
    unit_price * quantity
  end
end