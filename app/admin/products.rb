ActiveAdmin.register Product do

  index do
    column :name
    column :price
    #column :active
    column :image do |product|
      image_tag(product.image_handlers.first.image.url(:thumb).to_s)
    end
    column :sections
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.actions
    @product = Product.find(params[:id]) unless params[:id].nil?
    @images = @product.image_handlers unless @product.nil?
    f.inputs "Product" do
      f.input :name
      f.input :active, :as => :hidden
      f.input :price
      f.input :supports_grind
      f.input :content, :input_html => { :class => 'ckeditor' } #, :as => :ckeditor
      f.input :description, :hint => "This is the brief description that shows on menus"
      f.input :sections, :hint => "Hold CTRL+Click to deselect"
      if @images.nil?
        f.input :image_handlers, :label => "Image".html_safe,
                :collection => options_for_select(ImageHandler.all.map { |c| [c.alt, c.id, {'data-img-src' => c.image.url(:thumb).to_s}]}),
                :input_html => { :multiple => false, :class => 'image-picker' },
                :include_blank => false
      else
        f.input :image_handlers, :label => "Image".html_safe,
                :collection => options_for_select(ImageHandler.all.map { |c| [c.alt, c.id, {'data-img-src' => c.image.url(:thumb).to_s}]},
                                                  @images.collect{|img| img.id.to_s}),
                :input_html => { :multiple => false, :class => 'image-picker' },
                :include_blank => false
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      #row :active
      row :price do |product|
        number_to_currency(product.price, :unit => "$")
      end
      row :supports_grind
      row :description
      row :content do |page|
        page.content.html_safe
      end
      row :image do |product|
        image_tag(product.image_handlers.first.image.url.to_s)
      end
    end
    active_admin_comments
  end

end
