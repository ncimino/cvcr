class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  def destroy
    session.delete(:cart_id)
    @cart = @current_cart
    redirect_to cart_url
  end
end