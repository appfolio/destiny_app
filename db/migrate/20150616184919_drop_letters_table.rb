class DropLettersTable < ActiveRecord::Migration
  def up
    drop_table :letters
  end

  def down
    create_table :letters do |t|
      t.string :content

      t.timestamps
    end
  end
end
