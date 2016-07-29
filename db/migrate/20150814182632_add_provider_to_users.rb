class AddProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    remove_column :users, :remember_created_at
    remove_column :users, :mobile_number
  end
end
