class CreatePagesSections < ActiveRecord::Migration
  def self.up
    create_table :pages_sections, :id => false do |t|
      t.integer :page_id
      t.integer :section_id
    end
    add_index :pages_sections, [:section_id, :page_id],
              :unique => true
    add_index :pages_sections, :page_id, :unique => false
  end

  def self.down
    drop_table :pages_sections
  end
end
