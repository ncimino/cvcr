class ApplicationController < ActionController::Base
  before_filter :get_variables, :current_cart

  def get_variables
    @areas = MainArea.all
    if @areas.size > 0
      @bottom_area = MainArea.find_by_area_name(1)
      if @bottom_area
        @bottom_section = @bottom_area.sections.order("ordinal").includes(:products, :pages)
        if @bottom_section && @bottom_section.first
          @bottom_pages = @bottom_section.first.pages
        end
      end
    end
    if @areas.size > 1
      @area1 = MainArea.find_by_area_name(2)
      @area1_sections = @area1.sections.order("ordinal").includes(:products, :pages)
    end
    if @areas.size > 2
      @area2 = MainArea.find_by_area_name(3)
      @area2_sections = @area2.sections.order("ordinal").includes(:products, :pages)
    end
    if @areas.size > 3
      @area3 = MainArea.find_by_area_name(4)
      @area3_sections = @area3.sections.order("ordinal").includes(:products, :pages)
    end
    if @areas.size > 4
      @area4 = MainArea.find_by_area_name(5)
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

