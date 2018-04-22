class ChangeStatusToOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :status, :integer, default: 0
  end
end
