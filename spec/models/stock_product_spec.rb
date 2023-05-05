require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um código aleatório' do
    it 'ao criar um novo produto em estoque' do
      #Arrange 
        user = User.create!(name: 'Flavio', email: 'flavio@funcionario.com.br', password: 'flaviosoueu123')
        warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
        supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
        order = Order.new(user: user, warehouse: warehouse, supplier: supplier, date_delivery: "2024-01-01")
        product_model = ProductModel.create!(name:'TV 40 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV40-SAMSU-XPTO90ASD', supplier: supplier)

      #Act
        stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_model)
        result = stock_product.serial

      #Assert
        expect(result).not_to be_empty
        expect(result.length).to eq 20
    end
  end
end
