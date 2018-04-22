class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id, default: 0
      t.timestamps
    end
    add_index :categories, :name
  end
end
