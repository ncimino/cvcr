ActiveAdmin.register ImageHandler, :as => "Image" do

  index do
    column :title
    column :alt
    #column image_tag painting.image_url(:thumb)
    column :image do |img|
      image_tag(img.image.url(:thumb).to_s)
    end
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "Image" do
      f.input :title
      f.input :alt
      f.input :image, :as => :file, :label => "Image Upload"
      f.input :remote_image_url, :label => "or a Image URL (web address)"
    end
    f.buttons
  end

  show do
    attributes_table do
      row :title
      row :alt
      row :image do |img|
        image_tag(img.image.url.to_s)
      end
    end
    active_admin_comments
  end

end
