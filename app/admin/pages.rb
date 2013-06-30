ActiveAdmin.register Page do

  index do
    column :name
    column :title
    column :ordinal
    column :sections
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    @page = Page.find(params[:id]) unless params[:id].nil?
    @images = @page.image_handlers unless @page.nil?
    f.inputs "Page" do
      f.input :name, :label => 'Link Text'
      f.input :title
      f.input :ordinal, :input_html => { :value => 50 }
      f.input :url, :as => :url
      f.input :sections, :hint => "Hold CTRL+Click to deselect"
      if @images.nil?
        f.input :image_handlers, :label => "Images for Carousel".html_safe,
                :collection => options_for_select(ImageHandler.all.map { |c| [c.title, c.id, {'data-img-src' => c.image.url(:thumb).to_s}]}),
                :input_html => { :multiple => true, :class => 'image-picker' },
                :include_blank => false, :hint => "If _no_ pictures are selected, then a carousel will _not_ be displayed on this page"
      else
        f.input :image_handlers, :label => "Images for Carousel".html_safe,
                :collection => options_for_select(ImageHandler.all.map { |c| [c.title, c.id, {'data-img-src' => c.image.url(:thumb).to_s}]},
                                                  @images.collect{|img| img.id.to_s}),
                :input_html => { :multiple => true, :class => 'image-picker' },
                :include_blank => false, :hint => "If _no_ pictures are selected, then a carousel will _not_ be displayed on this page"
      end
      f.input :content, :as => :ckeditor
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :title
      row :ordinal
      row :sections
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
