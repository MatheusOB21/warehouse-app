require 'rails_helper'

describe 'Usuário busca por pedido' do
  it 'porém deve estar autenticado' do
    #Arrange

    #Act
      visit root_path 
    #Assert
      within('nav') do
        expect(page).not_to have_content ('Buscar pedido')
        expect(page).not_to have_button ('Buscar')
        expect(page).not_to have_button ('Sair')
      end
  end

  it 'a partir do menu' do
    #Arrange
      user = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')
    
    #Act
      login_as(user)
      visit root_path 
    
    #Assert
      within('nav') do
        expect(page).to have_content ('Buscar pedido')
        expect(page).to have_button ('Buscar')
        expect(page).to have_button ('Sair')
      end

  end

  it 'e encontra um' do
    #Arrange
     user = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')
     warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
     supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
     
     order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, date_delivery: 5.day.from_now)
    
    #Act
      login_as(user)
      visit root_path 
      fill_in 'Buscar pedido', with: order.code
      click_on 'Buscar'
    
    #Assert
      expect(page).to have_content ("Resultados da busca de: #{order.code}")
      expect(page).to have_content ('Pedido encontrado: 1')
      expect(page).to have_content ("Número do pedido: #{order.code}")
      expect(page).to have_content ("Galpão destino: RDU - Rio Gate")
      expect(page).to have_content ("Fornecedor responsável: Mistery Inc")
   end
  
   it 'e encontra vários' do
    #Arrange
      user1 = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')
      user2 = User.create!(name: 'Admin', email: 'admin@gmail.com', password: 'senha_padrao_admin')
      
      warehouse1 = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
      warehouse2 = Warehouse.create!(name: 'Sao Paulo Gate', code: 'SPA', city: 'São Paulo', area: 50_000, adress: "Avenida das Livreiras, 1500", cep: '51000-000', description: 'Galpão do São Paulo')
      
      supplier1 = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
      supplier2 = Supplier.create!(corporate_name: "Flauta LTDA", brand_name: "Flauta", registration_number:"14565845612345", full_address: "Avenida One, 151", city: "New Jersy", state: "WS", email: "contato@fluta.com.br")
      
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('FGA2GJH7KL')
      order1 = Order.create!(user: user1, warehouse: warehouse2, supplier: supplier1, date_delivery: 5.day.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('FGA&YK98AX')
      order2 = Order.create!(user: user1, warehouse: warehouse2, supplier: supplier2, date_delivery: 5.day.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('RDU2F3H6J8')
      order3 = Order.create!(user: user2, warehouse: warehouse1, supplier: supplier2, date_delivery: 5.day.from_now)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('RDU2T4YIOP')
      order4 = Order.create!(user: user2, warehouse: warehouse1, supplier: supplier1, date_delivery: 5.day.from_now)
    
    #Act
      login_as(user2)
      visit root_path 
      fill_in 'Buscar pedido', with: "RDU"
      click_on 'Buscar'
    
    #Assert
      expect(page).to have_content ("Resultados da busca de: RDU")
      expect(page).to have_content ('Pedidos encontrados: 2')
      
      #Precisa aparecer o pedido 3 e 4
      expect(page).to have_content ("Número do pedido: #{order3.code}")
      expect(page).to have_content ("Galpão destino: RDU - Rio Gate")
      expect(page).to have_content ("Fornecedor responsável: Flauta LTDA")
      
      expect(page).to have_content ("Número do pedido: #{order4.code}")
      expect(page).to have_content ("Galpão destino: RDU - Rio Gate")
      expect(page).to have_content ("Fornecedor responsável: Mistery Inc")
      
      #Não é para aparece o pedido 1
      expect(page).not_to have_content ("Número do pedido: #{order1.code}")
      expect(page).not_to have_content ("Galpão destino: SPA - Sao Paulo Gate")
   end
  
end