ActiveAdmin.register Page do

  index do
    column :name
    column :title
    column :ordinal
    column :location
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    @page = Page.find(params[:id])
    @images = @page.image_handlers
    f.inputs "Page" do
      f.input :name
      f.input :title
      f.input :ordinal
      f.input :url, :as => :url
      f.input :location, :as => :select,
              :collection => [['Top', 'topbar'],
                              ['Bottom', 'bottombar'],
                              ['Disabled', 'off']]
      f.input :image_handlers, :label => "Images for Carousel".html_safe,
              :collection => options_for_select(ImageHandler.all.map { |c| [c.title, c.id, {'data-img-src' => c.image.url(:thumb).to_s}]},
                                                @images.collect{|img| img.id
                                                .to_s}),
              :input_html => { :multiple => true, :class => 'image-picker' },
              :include_blank => false
      f.input :content, :as => :ckeditor
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :title
      row :ordinal
      row :location
      #row :image_handlers do |page|
      #  page.image_handlers { |img| img.image }
      #end
      row :content do |page|
        page.content.html_safe
      end
    end
    active_admin_comments
  end

end
