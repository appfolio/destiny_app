class AddKeySlotToChests < ActiveRecord::Migration
  def change
    add_column :chests, :key_slot, :string
  end
end
