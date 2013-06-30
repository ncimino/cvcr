class ApplicationController < ActionController::Base
  #filter_parameter_logging :password

  before_filter :get_variables, :current_cart

  def get_variables
    #@display_pages = Page.order("ordinal")
    @display_sections = Section.order("ordinal").includes(:products, :pages)

    @display_sections.bottom.each { |s|
      @display_bottom_pages = s.pages.order ("ordinal")
    } unless @display_sections.nil?

    @display_products_section = Array.new
    @display_sections.products.each { |s|
      @display_products_section.push(s)
    } unless @display_sections.nil?

    @display_drinks_section = Array.new
    @display_sections.drinks.each { |s|
      @display_drinks_section.push(s)
    } unless @display_sections.nil?

    @display_contact_section = Array.new
    @display_sections.contact.each { |s|
      @display_contact_section.push(s)
    } unless @display_sections.nil?

    @display_events_section = Array.new
    @display_sections.events.each { |s|
      @display_events_section.push(s)
    } unless @display_sections.nil?
  end

  protect_from_forgery

  def current_cart
    @current_cart ||= Cart.where(:id => session[:cart_id]).first_or_create()
        #find_or_create_by!(cart_id: session[:cart_id])
    #if session[:cart_id]
    #  @current_cart ||= Cart.find(session[:cart_id])
    #  session[:cart_id] = nil if @current_cart.purchased_at
    #end
    #if session[:cart_id].nil?
    #  @current_cart = Cart.create!
    #  session[:cart_id] = @current_cart.id
    #end
    @current_cart
  end
end
