ActiveAdmin.register Page do

  index do
    column :name
    column :title
    column :ordinal
    column :location
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "Page" do
      f.input :name
      f.input :title
      f.input :ordinal
      f.input :url, :as => :url
      f.input :location, :as => :select,
              :collection => [['Top', 'topbar'], ['Userbar', 'userbar'],
                              ['Sidebar', 'sidebar'], ['Bottom', 'bottombar'],
                              ['Disabled', 'off']]
      f.input :content, :as => :ckeditor
    end
    f.buttons
  end

end
