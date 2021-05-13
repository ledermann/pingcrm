# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :password

    change_table :users, bulk: true do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove_index :email
      t.remove_index :reset_password_token

      t.remove_column :encrypted_password
      t.remove_column :reset_password_sent_at
      t.remove_column :reset_password_token
      t.remove_column :remember_created_at

      t.add_column :password, :string
    end
  end
end
