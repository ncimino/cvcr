ActiveAdmin.register PaymentNotification do

  actions :all, :except => [:new, :edit]    #:destroy

  index do
    column :cart_id
    column :status
    column :transaction_id
    column :created_at
    column :updated_at

    default_actions
  end

  form :html => {:multipart => true}  do |f|
    f.inputs "PaymentNotification" do
      f.input :cart_id
      f.input :status
      f.input :params
    end
    f.actions
  end


  show do
    attributes_table do
      row :cart_id
      row :status
      row :transaction_id
      row :params
      #do |payment|
        #JSON.pretty_generate(payment.params.to_json)
        #payment.params.to_json
      #  payment.params.gsub(/{/, "<pre>\n ").gsub!(/}/, "</pre>").gsub!(/,/, ",\n").html_safe
      #end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
