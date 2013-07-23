class CreateMainAreas < ActiveRecord::Migration
  def up
    create_table :main_areas do |t|
      t.string :title
      t.string :area_name
      t.string :link
      t.integer :ordinal
    end
  end

  def down
    drop_table :main_areas
  end
end
