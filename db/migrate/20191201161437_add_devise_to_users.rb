# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[6.0]
  def self.up
    remove_column :users, :password

    change_table :users do |t|
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

  def self.down
    remove_index :users, :email
    remove_index :users, :reset_password_token

    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_sent_at
    remove_column :users, :reset_password_token
    remove_column :users, :remember_created_at

    add_column :users, :password, :string
  end
end
