class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.float :total, default: 0
      t.boolean :status
      t.timestamps
    end
  end
end
