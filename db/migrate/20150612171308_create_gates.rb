class CreateGates < ActiveRecord::Migration
  def change
    create_table :gates do |t|
      t.boolean :is_locked
      t.string :tables_prefix

      t.timestamps
    end
  end
end
