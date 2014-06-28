class AddGrindToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :grind, :string, default: 'Whole Bean'
  end
end
