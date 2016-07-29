class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :content

      t.timestamps
    end
  end
end
