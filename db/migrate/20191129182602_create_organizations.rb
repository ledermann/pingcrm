class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :region
      t.string :country
      t.string :postal_code
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
