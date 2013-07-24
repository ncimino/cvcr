ActiveAdmin.register Section do

  index do
    column :title
    column :ordinal
    #column :location
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "Section" do
      f.input :title
      f.input :link, :as => :url
      f.input :ordinal
      f.input :main_areas, :hint => "Hold CTRL+Click to deselect"
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :link
      row :ordinal
      #row :location
    end
    active_admin_comments
  end

end
