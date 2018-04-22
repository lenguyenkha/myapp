class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :quality
      t.string :detail
      t.string :picture
      t.references :category, foreign_key: true
      t.timestamps
    end
    add_index :products, :name
    add_index :products, :price
  end
end
