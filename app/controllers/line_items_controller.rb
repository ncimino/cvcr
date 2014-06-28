class LineItemsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @cart = @current_cart

#   if !@cart.line_items.exists?(:product_id => @product.id)
      @line_item = LineItem.create!( :cart => @cart, :product => @product, :quantity => 1, :unit_price => @product.price )
#   else
#     @cart.line_items.find(:first, :conditions =>{:product_id => @product.id}).increment! :quantity
#   end

    flash[:success] = "Added '#{@product.name}' to cart."
    redirect_to :cart
  end

  def set_grind
    @line_item = LineItem.find(params[:id])
    @line_item.update_attribute :grind, params[:grind]

    flash[:success] = "Grind type set to '#{@line_item.grind}' for '#{@line_item.product.name}'."
    redirect_to :cart
  end

  def increment
    @line_item = LineItem.find(params[:id])
    @line_item.increment! :quantity
    @cart = @current_cart

    flash[:success] = "Added '#{@line_item.product.name}' to cart."
    redirect_to cart_url
  end

  def decrement
    @line_item = LineItem.find(params[:id])
    @line_item.decrement! :quantity
    if @line_item.quantity <= 0
      @line_item.destroy
    end
    flash[:success] = "Removed #{@line_item.product.name} from cart."
    @cart = @current_cart
    redirect_to cart_url
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    flash[:success] = "Removed #{@line_item.product.name} from cart."
    @line_item.destroy
    @cart = @current_cart

    redirect_to cart_url
  end
end