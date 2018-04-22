class CreateSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :product_name
      t.string :detail
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
