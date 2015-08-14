class AddIdentityUrlToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :identity_url
      t.remove :mobile_number
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
    end

    add_index :users, :identity_url, unique: true
  end

  def down
    change_table :users do |t|
      t.remove :identity_url
      t.string :mobile_number
      t.string :reset_password_token, unique: true
      t.datetime :reset_password_sent_at
      t.string :confirmation_token, unique: true
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end
  end
end
