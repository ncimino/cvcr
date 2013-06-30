class ApplicationController < ActionController::Base

  before_filter :get_variables

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
end
