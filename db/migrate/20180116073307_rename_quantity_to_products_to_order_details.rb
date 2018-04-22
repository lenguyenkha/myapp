class RenameQuantityToProductsToOrderDetails < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :quality, :quantity
    rename_column :order_details, :quality, :quantity
  end
end
