class CreateCarts < ActiveRecord::Migration
  def up
    create_table :carts do |t|
      t.datetime :purchased_at
      t.timestamps
    end
  end

  def down
    drop_table :carts
  end
end