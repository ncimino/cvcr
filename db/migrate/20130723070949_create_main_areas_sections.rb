class CreateMainAreasSections < ActiveRecord::Migration
  def self.up
    create_table :main_areas_sections, :id => false do |t|
      t.integer :main_area_id
      t.integer :section_id
    end
    add_index :main_areas_sections, [:section_id, :main_area_id],
              :unique => true
    add_index :main_areas_sections, :main_area_id, :unique => false
  end

  def self.down
    drop_table :main_areas_sections
  end
end
