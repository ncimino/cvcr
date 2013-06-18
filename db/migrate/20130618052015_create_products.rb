class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price,        :precision => 10, :scale => 2
      t.text :description
      t.string :image
      t.boolean :active

      t.timestamps
    end
    add_index "products", ["active"], :name => "index_active_products"
  end
end
