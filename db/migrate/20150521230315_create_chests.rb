class CreateChests < ActiveRecord::Migration
  def change
    create_table :chests do |t|
      t.string :size
      t.string :color

      t.timestamps
    end
  end
end
