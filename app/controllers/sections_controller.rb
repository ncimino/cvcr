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

  # GET /products
  def products
    @sections = Section.products
    @title = 'Products'

    if @sections
      render 'index'
    else
      redirect_to root_url
    end
  end

  # GET /drinks
  def drinks
    @sections = Section.drinks
    @title = 'Drinks'

    if @sections
      render 'index'
    else
      redirect_to root_url
    end
  end

  # GET /contact
  def contact
    @sections = Section.contact
    @title = 'Contact'

    if @sections
      render 'index'
    else
      redirect_to root_url
    end
  end

  # GET /events
  def events
    @sections = Section.events
    @title = 'Events'

    if @sections
      render 'index'
    else
      redirect_to root_url
    end
  end

end
