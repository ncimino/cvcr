class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :title
      t.string :link
      t.string :location
      t.integer :ordinal
    end
  end

  def self.down
    drop_table :sections
  end
end
