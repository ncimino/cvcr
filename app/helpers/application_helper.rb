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
    image_tag("cvcr.jpeg", {:alt => "Carbon Valley Coffee Roasters Logo", :class => "img-circle pull-right", :style => "width: 250px; height: 250px"})
  end
end
