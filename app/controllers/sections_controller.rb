class SectionsController < ApplicationController

  # GET /sections/1
  def show
    @section = Section.find(params[:id])

    if @section
      #show.html.erb
    else
      redirect_to root_url
    end
  end

end
