class LineItemsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @cart = current_cart
    #@line_items = @cart.line_items
    #@line_items.each { |item|
    #  @line_item ||= (item.product == @product) ? item : nil
    #}
    #if @line_item
    #  @line_item.
    #else
    #  @line_item = LineItem.create!(:cart => @cart, :product => @product, :quantity => 1, :unit_price => @product.price)
    #end

    if !@cart.line_items.exists?(:product_id => @product.id)
      @line_item = LineItem.create!(:cart => @cart, :product => @product, :quantity => 1, :unit_price => @product.price)
    else
      @cart.line_items.find(:first, :conditions =>{:product_id => @product.id}).increment! :quantity
    end

    flash[:success] = "Added #{@product.name} to cart."
    redirect_to :cart
  end
end