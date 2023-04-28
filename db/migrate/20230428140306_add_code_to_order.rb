class AddCodeToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :code, :integer
  end
end
