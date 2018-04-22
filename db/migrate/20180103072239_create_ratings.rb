class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rate
      t.timestamps
    end
  end
end
