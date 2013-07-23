class MainAreasController < ApplicationController

  # GET /areas/1
  def show
    @area = MainArea.find(params[:id])

    if @area
      #show.html.erb
    else
      redirect_to root_url
    end
  end

end
