class RenameCepTocep < ActiveRecord::Migration[7.0]
  def change
    rename_column :warehouses, :CEP, :cep
  end
end
