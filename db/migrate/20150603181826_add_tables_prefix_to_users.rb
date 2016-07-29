class AddTablesPrefixToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tables_prefix, :string
  end
end
