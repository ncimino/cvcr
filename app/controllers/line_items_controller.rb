class LineItemsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @line_item = LineItem.create!(:cart => current_cart, :product => @product, :quantity => 1, :unit_price => @product.price)
    flash[:success] = "Added #{@product.name} to cart."
    redirect_to :cart
  end
end