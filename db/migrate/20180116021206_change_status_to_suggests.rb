class ChangeStatusToSuggests < ActiveRecord::Migration[5.1]
  def change
    change_column :suggests, :status, :integer, default: 0
  end
end
