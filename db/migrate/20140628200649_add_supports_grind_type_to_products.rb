class AddSupportsGrindTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :supports_grind, :boolean, default: 1
  end
end
