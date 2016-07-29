class AddCsrfEmailReadToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.boolean :csrf_email_read, default: false, null: false
    end
  end
end
