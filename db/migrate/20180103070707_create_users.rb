class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :gender
      t.string :address
      t.string :phone
      t.string :email
      t.string :password_digest
      t.string :rember_digest
      t.datetime :reset_send_at
      t.boolean :is_admin, default: false
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
