class Contacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.integer :user_id
      t.string :token_key
      t.boolean :active
      t.string :status
      t.timestamps null: false
    end
  end
end
