class ApplicationController < ActionController::Base

  before_filter :get_variables

  def get_variables
    @display_pages = Page.order("ordinal")
    @display_sections = Section.order("ordinal")
    @display_sections.bottom.each { |s| @display_bottom_pages = s.pages } unless @display_sections.nil?
  end

  protect_from_forgery
end
