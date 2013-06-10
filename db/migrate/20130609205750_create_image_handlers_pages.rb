class CreateImageHandlersPages < ActiveRecord::Migration
  def self.up
    create_table :image_handlers_pages, :id => false do |t|
      t.integer :page_id
      t.integer :image_handler_id
    end
    add_index :image_handlers_pages, [:image_handler_id, :page_id],
              :unique => true
    add_index :image_handlers_pages, :page_id, :unique => false
  end

  def self.down
    drop_table :image_handlers_pages
  end
end
