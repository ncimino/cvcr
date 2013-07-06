ActiveAdmin.register PaymentNotification do

  actions :all, :except => [:create, :destroy, :edit]

  index do
    column :cart_id
    column :status
    column :transaction_id
    column :params
    column :created_at
    column :updated_at

    default_actions
  end

  show do
    attributes_table do
      row :cart_id
      row :status
      row :transaction_id
      row :params
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
