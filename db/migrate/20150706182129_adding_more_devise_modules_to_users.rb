class AddingMoreDeviseModulesToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.remove :authentication_token

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email
    end

    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end

  def self.down
    change_table(:users) do |t|
      t.string :authentication_token

      ## Recoverable
      t.remove    :reset_password_token
      t.remove    :reset_password_sent_at

      ## Confirmable
      t.remove    :confirmation_token
      t.remove    :confirmed_at
      t.remove    :confirmation_sent_at
      t.remove    :unconfirmed_email
    end

    add_index :users, :authentication_token, unique: true
  end
end
