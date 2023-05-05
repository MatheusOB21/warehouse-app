class AddCodeToStockProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :stock_products, :code, :string
  end
end
