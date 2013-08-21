ActiveAdmin.register Parameter do

  index do
    column :key
    column :value
    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "Parameter" do
      f.input :key, :as => :select,
              :collection => [['payment-email', 'payment-email']]
      f.input :value
    end
    f.actions
  end

  show do
    attributes_table do
      row :key
      row :value
    end
    active_admin_comments
  end

end
