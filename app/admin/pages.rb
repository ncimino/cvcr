ActiveAdmin.register Page do

  index do
    column :name
    column :description
    column :ordinal
    column :sections
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    @page = Page.find(params[:id]) unless params[:id].nil?
    @images = @page.image_handlers unless @page.nil?
    f.inputs "Page" do
      f.input :name, :label => 'Link Text', :hint => 'Menu button text'
      f.input :title, :hint => 'Shows at top of page'
      f.input :ordinal
      f.input :url, :as => :url, :hint => 'Use this to link to a specifc URL, this means that the page content will never be displayed (creates a link)'
      f.input :sections, :hint => "Hold CTRL+Click to deselect"
      if @images.nil?
        f.input :image_handlers, :label => "Images for Carousel".html_safe,
                :collection => options_for_select(ImageHandler.all.map { |c| [c.alt, c.id, {'data-img-src' => c.image.url(:thumb).to_s}]}),
                :input_html => { :multiple => true, :class => 'image-picker' },
                :include_blank => false, :hint => "If _no_ pictures are selected, then a carousel will _not_ be displayed on this page"
      else
        f.input :image_handlers, :label => "Images for Carousel".html_safe,
                :collection => options_for_select(ImageHandler.all.map { |c| [c.alt, c.id, {'data-img-src' => c.image.url(:thumb).to_s}]},
                                                  @images.collect{|img| img.id.to_s}),
                :input_html => { :multiple => true, :class => 'image-picker' },
                :include_blank => false, :hint => "If _no_ pictures are selected, then a carousel will _not_ be displayed on this page"
      end
      f.input :content, :as => :ckeditor
      f.input :description, :hint => "This is the brief description that shows on menus"
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :title
      row :ordinal
      row :sections
      row :description
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
