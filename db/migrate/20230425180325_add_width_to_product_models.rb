class AddWidthToProductModels < ActiveRecord::Migration[7.0]
  def change
    add_column :product_models, :width, :integer
  end
end
