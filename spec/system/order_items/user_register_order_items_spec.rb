require 'rails_helper'

describe 'Usuário cadastra novo item do pedido' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Luiz', email: 'luiz@gmail.com', password:'admin12345')  
      
    warehouse = Warehouse.create(name: 'Aeroporto SP', code:'GRU', city: 'Guarulhos', area: 100000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')  
    
    product_model_1 = ProductModel.create!(name:'TV 40 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV40-SAMSU-XPTO90ASD', supplier: supplier)
    product_model_2 = ProductModel.create!(name:'TV 50 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV50-SAMSU-XPTO90QWR', supplier: supplier)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, date_delivery: 5.day.from_now, status: 'delivered')
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'
    select 'TV 40 UHD 4k', from: 'Modelo de produto'
    fill_in 'Quantidade', with: 10
    click_on 'Adicionar'
    #Assert 
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content '10x TV 40 UHD 4k - TV40-SAMSU-XPTO90ASD'
    expect(page).to have_content 'Item adicionado'
  end
  it 'que não é de outro fornecedor' do
    #Arrange
    user = User.create!(name: 'Luiz', email: 'luiz@gmail.com', password:'admin12345')  
      
    warehouse = Warehouse.create(name: 'Aeroporto SP', code:'GRU', city: 'Guarulhos', area: 100000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    
    supplier_1 = Supplier.create!(brand_name: 'Samsung Inc.', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')  
    supplier_2 = Supplier.create!(brand_name: 'Apple Inc.', corporate_name: 'Apple', registration_number: '78945678914456', full_address: 'Av das Liberdades, 100', city: 'São Paulo', state: 'SP', email: 'sac@apple.com.br')  
    
    product_model_1 = ProductModel.create!(name:'TV 40 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV40-SAMSU-XPTO90ASD', supplier: supplier_1)
    product_model_2 = ProductModel.create!(name:'TV 50 UHD 4k', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV50-SAMSU-XPTO90QWR', supplier: supplier_2)

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_1, date_delivery: 5.day.from_now, status: 'delivered')

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'
    #Assert 
    expect(page).to have_content 'TV 40 UHD 4k'
    expect(page).not_to have_content 'TV 50 UHD 4k'
  end
end