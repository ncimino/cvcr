class CreateImageHandlersProducts < ActiveRecord::Migration
  def self.up
    create_table :image_handlers_products, :id => false do |t|
      t.integer :product_id
      t.integer :image_handler_id
    end
    add_index :image_handlers_products, [:image_handler_id, :product_id],
              :unique => true
    add_index :image_handlers_products, :product_id, :unique => false
  end

  def self.down
    drop_table :image_handlers_products
  end
end

