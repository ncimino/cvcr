ActiveAdmin.register ImageHandler, :as => "Image" do

  index do
    column :title
    column :alt
    column :image do |img|
      image_tag(img.image.url(:thumb).to_s)
    end
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "Image" do
      f.input :title, :hint => 'If used in a carousel, then this is the title that will show (without this the shaded part at the bottom will not show)'
      f.input :description, :hint => 'If used in a carousel, then this is the descriptive text that will show'
      f.input :button_text, :hint => 'If used in a carousel, then this is the text inside the button (without this the button will not show)'
      f.input :button_url, :hint => 'If used in a carousel, this is where the user will be redirected when the button is clicked'
      f.input :alt, :label => "Hidden Text", :hint => 'This is alternate text that will show if the image cannot be displayed (this is good to use for search engine optimization)'
      f.input :link, :hint => 'Set this URL if you would like the user to be able to click on the image and be taken to another page'
      f.input :image, :as => :file, :label => "Image Upload",
              :hint => "Choose file to replace the current image".html_safe
      #:hint => "#{f.template.image_tag(f.object.image.url(:thumb))} - Choose file to replace the current image".html_safe
      f.input :remote_image_url, :label => "or a Image URL (web address)",
              :hint => 'Use a URL to an image on the web'
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :button_text
      row :button_url
      row :alt
      row :link
      row :image do |img|
        image_tag(img.image.url.to_s)
      end
    end
    active_admin_comments
  end

end
