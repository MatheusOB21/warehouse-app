class RenameColumnCodeToSerialNumber < ActiveRecord::Migration[7.0]
  def change
    rename_column :stock_products, :code, :serial
  end
end
