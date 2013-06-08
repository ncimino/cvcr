class CreateImageHandlers < ActiveRecord::Migration
  def change
    create_table :image_handlers do |t|
      t.string :title
      t.string :alt
      t.string :image

      t.timestamps
    end
  end
end
