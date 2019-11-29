class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password
      t.boolean :owner, null: false, default: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
