class ApplicationController < ActionController::Base
  before_filter :get_variables, :current_cart

  def get_variables
    if @bottom_area = MainArea.find_by_area_name(1)
      @bottom_sections = @bottom_area.sections.order("ordinal").includes(:products, :pages)
    end
    Rails.logger.debug "====================== #{@bottom_area.area_name}"
    if @area1 = MainArea.find_by_area_name(2)
      @area1_sections = @area1.sections.order("ordinal").includes(:products, :pages)
    end
    if @area2 = MainArea.find_by_area_name(3)
      @area2_sections = @area2.sections.order("ordinal").includes(:products, :pages)
    end
    if @area3 = MainArea.find_by_area_name(4)
      @area3_sections = @area3.sections.order("ordinal").includes(:products, :pages)
    end
    if @area4 = MainArea.find_by_area_name(5)
      @area4_sections = @area4.sections.order("ordinal").includes(:products, :pages)
    end
  end

  protect_from_forgery

  def current_cart
    @current_cart ||= Cart.where(:id => session[:cart_id]).first_or_create()
    session[:cart_id] = @current_cart.id
    if @current_cart.purchased_at
      session[:cart_id] = nil
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end
end

