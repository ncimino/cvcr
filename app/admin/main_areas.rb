ActiveAdmin.register MainArea do

  index do
    column :title
    column :area_name
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "Section" do
      f.input :title
      f.input :area_name, :as => :select,
              :collection => [['disabled', 0],
                              ['bottom', 1],
                              ['main_area_1', 2],
                              ['main_area_2', 3],
                              ['main_area_3', 4],
                              ['main_area_4', 5]]
      f.input :link, :as => :url, :hint => "Leave blank, unless you want a main button to link directly to a page, then use the URL here"
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :link
      row :area_name
    end
    active_admin_comments
  end

end
