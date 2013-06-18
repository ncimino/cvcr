class CreateProductsSections < ActiveRecord::Migration
  def self.up
    create_table :products_sections, :id => false do |t|
      t.integer :product_id
      t.integer :section_id
    end
    add_index :products_sections, [:section_id, :product_id],
              :unique => true
    add_index :products_sections, :product_id, :unique => false
  end

  def self.down
    drop_table :products_sections
  end
end
