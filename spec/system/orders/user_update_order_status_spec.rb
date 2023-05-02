require 'rails_helper'

describe 'Usuário atualiza status do pedido' do
  it 'para entregue' do
    #Arrange
      user = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')

      warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
      supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, date_delivery: 5.day.from_now, status: 'pending')
    
    #Act
      login_as(user)
      visit root_path
      within('nav') do
        click_on "Meus Pedidos"
      end
      click_on order.code
      click_on "Pedido recebido"

    #Assert
      expect(current_path).to eq order_path(order.id)
      expect(page).to have_content 'Status do pedido: Entregue'
      expect(page).not_to have_button 'Pedido recebido'
      expect(page).not_to have_button 'Pedido cancelado'
  end

  it 'para cancelado' do
    #Arrange
      user = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')

      warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
      supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, date_delivery: 5.day.from_now, status: 'pending')
    
    #Act
      login_as(user)
      visit root_path
      within('nav') do
        click_on "Meus Pedidos"
      end
      click_on order.code
      click_on "Pedido cancelado"

    #Assert
      expect(current_path).to eq order_path(order.id)
      expect(page).to have_content 'Status do pedido: Cancelado'
      expect(page).not_to have_button 'Pedido recebido'
      expect(page).not_to have_button 'Pedido cancelado'
  end

end