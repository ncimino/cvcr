class AddDescAndLinkToImageHandlers < ActiveRecord::Migration
  def change
    add_column :image_handlers, :description, :text
    add_column :image_handlers, :button_text, :string
    add_column :image_handlers, :button_url, :string
    add_column :image_handlers, :link, :string
  end
end
