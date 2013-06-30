class CreateLineItems < ActiveRecord::Migration
  def up
    create_table :line_items do |t|
      t.decimal  'unit_price',        :precision => 10, :scale => 2
      t.integer  'product_id'
      t.integer  'cart_id'
      t.integer  'quantity'
      t.timestamps
    end
  end

  def down
    drop_table :line_items
  end
end
