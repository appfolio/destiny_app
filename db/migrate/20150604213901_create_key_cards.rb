class CreateKeyCards < ActiveRecord::Migration
  def up
    create_table :key_cards do |t|
      t.string :blade

      t.timestamps
    end

    load File.join(Rails.root, "db/seeds.rb")
  end

  def down
    Chest.destroy_all
    drop_table :key_cards
  end
end
