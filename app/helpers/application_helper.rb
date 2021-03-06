module ApplicationHelper
  def title(page_title)
    view_flow.content.delete(:title)
    content_for :title do
      page_title
    end
    page_title
  end

  def default_title(page_title)
    title page_title unless content_for?(:title)
  end

  def logo
    image_tag("cvcr.png", {:alt => "Carbon Valley Coffee Roasters Logo", :class => "img-circle img-logo", :style => "width: 200px; height: 200px"})
  end

  def root_logo
    image_tag("cvcr.png", {:alt => "Carbon Valley Coffee Roasters Logo", :class => "img-circle img-logo", :style => "width: 250px; height: 250px"})
  end
end
