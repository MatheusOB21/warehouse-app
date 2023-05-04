require 'rails_helper'

describe 'Usuário vê em seus pedidios ' do
  it 'os itens de um pedido' do
    #Arrange
      user = User.create!(name: 'Luiz', email: 'luiz@gmail.com', password:'admin12345')  
      
      warehouse = Warehouse.create(name: 'Aeroporto SP', code:'GRU', city: 'Guarulhos', area: 100000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')  
      
      product_model_1 = ProductModel.create!(name:'TV 40 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV40-SAMSU-XPTO90ASD', supplier: supplier)
      product_model_2 = ProductModel.create!(name:'TV 50 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV50-SAMSU-XPTO90QWR', supplier: supplier)
      product_model_3 = ProductModel.create!(name:'TV 60 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV60-SAMSU-XPTO90GTA', supplier: supplier)

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, date_delivery: 5.day.from_now, status: 'delivered')

      order_items_1 = OrderItem.create!(order: order, product_model: product_model_1, quantity: 20)
      order_items_2 = OrderItem.create!(order: order, product_model: product_model_2, quantity: 10)

    #Act
      login_as(user)
      visit root_path
      within('nav') do
        click_on "Meus Pedidos"
      end
      click_on order.code
    #Assert
      expect(current_path).to eq order_path(order.id)
      expect(page).to have_content "Produtos do pedido:"
      expect(page).to have_content "20x TV 40 UHD 4k - TV40-SAMSU-XPTO90"
      expect(page).to have_content "10x TV 50 UHD 4k - TV50-SAMSU-XPTO90"



  end
end