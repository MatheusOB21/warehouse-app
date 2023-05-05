require 'rails_helper'

describe 'Usuário os produtos em estoque' do
  it 'nos detalhes de um galpão' do
    #Arrange
      user = User.create!(name: 'Flavio', email: 'flavio@funcionario.com.br', password: 'flaviosoueu123')
      warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
      supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
      product_model_1 = ProductModel.create!(name:'TV 40 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV40-SAMSU-XPTO90ASD', supplier: supplier)
      product_model_2 = ProductModel.create!(name:'TV 50 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV50-SAMSU-LKAO90ZXC', supplier: supplier)
      product_model_3 = ProductModel.create!(name:'TV 60 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV60-SAMSU-MNJO90ZXV', supplier: supplier)

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, date_delivery: 5.day.from_now)

      5.times{stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_model_1)}
      5.times{stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_model_2)}

    #Act
      login_as(user)
      visit root_path
      click_on 'Rio Gate'

    #Assert
      expect(page).to have_content '5x TV 40 UHD 4k'
      expect(page).to have_content '5x TV 50 UHD 4k'
      expect(page).not_to have_content 'TV 60 UHD 4k'
  end
end