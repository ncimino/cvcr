ActiveAdmin.register Section do

  index do
    column :title
    column :ordinal
    column :location
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "Section" do
      f.input :title
      f.input :link, :as => :url
      f.input :ordinal
      f.input :location, :as => :select,
              :collection => [['Bottom', 'bottom'],
                              #['Products', 'products'],
                              ['Drinks', 'drinks'],
                              ['Contact', 'contact'],
                              ['Events', 'events'],
                              ['Disable', 'off']]
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :link
      row :ordinal
      row :location
    end
    active_admin_comments
  end

end
