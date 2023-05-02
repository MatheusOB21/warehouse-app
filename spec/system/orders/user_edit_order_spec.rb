require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e deve estar autenticado' do
    #Arrange 
      user = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')
      warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
      supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
    
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, date_delivery: 5.day.from_now)
    #Act
      visit order_path(order.id)
    #Assert
      expect(current_path).to eq new_user_session_path
  end
  
  it 'com sucesso' do
    #Arrange 
      user = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')
      
      warehouse1 = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
      warehouse2 = Warehouse.create!(name: 'Sao Paulo Gate', code: 'SPA', city: 'São Paulo', area: 50_000, adress: "Avenida das Livreiras, 1500", cep: '51000-000', description: 'Galpão do São Paulo')

      supplier1 = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
      supplier2 = Supplier.create!(corporate_name: "Flauta LTDA", brand_name: "Flauta", registration_number:"14565845612345", full_address: "Avenida One, 151", city: "New Jersy", state: "WS", email: "contato@fluta.com.br")

      order = Order.create!(user: user, warehouse: warehouse1, supplier: supplier1, date_delivery: 5.day.from_now)
    #Act
      login_as(user)
      visit root_path
      click_on "Meus Pedidos"
      click_on order.code
      click_on "Editar"
      fill_in "Data de entrega", with: "30/05/2023"
      select "Flauta LTDA", from: "Fornecedor"
      click_on "Enviar"

    #Assert
      expect(current_path).to eq order_path(order.id)
      expect(page).to have_content("Data de entrega: 30/05/2023")
      expect(page).to have_content("Fornecedor responsável: Flauta LTDA")
  end

  it 'porém não pode editar pedido que não é seu' do
        #Arrange 
        user = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')
        user2 = User.create!(name: 'Admin', email: 'admin@admin.com', password: 'admin1234')
       
        warehouse1 = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
        warehouse2 = Warehouse.create!(name: 'Sao Paulo Gate', code: 'SPA', city: 'São Paulo', area: 50_000, adress: "Avenida das Livreiras, 1500", cep: '51000-000', description: 'Galpão do São Paulo')
  
        supplier1 = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
        supplier2 = Supplier.create!(corporate_name: "Flauta LTDA", brand_name: "Flauta", registration_number:"14565845612345", full_address: "Avenida One, 151", city: "New Jersy", state: "WS", email: "contato@fluta.com.br")
  
        order1 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier1, date_delivery: 5.day.from_now)
        order2 = Order.create!(user: user, warehouse: warehouse2, supplier: supplier2, date_delivery: 5.day.from_now)
      #Act
        login_as(user2)
        visit edit_order_path(order1.id)
      #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content("Você não tem acesso a esse pedido")
    
  end
end