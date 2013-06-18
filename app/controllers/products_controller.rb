class ProductsController < ApplicationController
  def index
    @products = Product.all

    respond_to do |format|
      if @products
        format.html
        format.json { render json: @products }
      else
        format.html { redirect_to :admin_root }
        format.json { render json: @products.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product
        format.html
        format.json { render json: @product }
      else
        format.html { redirect_to :admin_root }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
end
