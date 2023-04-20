class AddAdressToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :adress, :string
  end
end
