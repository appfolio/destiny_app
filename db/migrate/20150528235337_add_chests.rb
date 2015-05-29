class AddChests < ActiveRecord::Migration
  def up
    down()

    Chest.create([{size: 'Large', color: 'Yellow'}, {size: 'Small', color: 'Orange'}])
  end

  def down
    Chest.destroy_all
  end
end
