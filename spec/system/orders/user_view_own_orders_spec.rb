require 'rails_helper'

describe 'usuário ver seus pedidos' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
      visit root_path
      within('nav') do
        click_on "Meus Pedidos"
      end
    #Assert
      expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    #Arrange
    user1 = User.create!(name: 'Matheus', email: 'matheuzin@gmail.com', password: 'senha_padrao')
    user2 = User.create!(name: 'Admin', email: 'admin@gmail.com', password: 'senha_padrao_admin')

    warehouse1 = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
    warehouse2 = Warehouse.create!(name: 'Sao Paulo Gate', code: 'SPA', city: 'São Paulo', area: 50_000, adress: "Avenida das Livreiras, 1500", cep: '51000-000', description: 'Galpão do São Paulo')
    
    supplier1 = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
    supplier2 = Supplier.create!(corporate_name: "Flauta LTDA", brand_name: "Flauta", registration_number:"14565845612345", full_address: "Avenida One, 151", city: "New Jersy", state: "WS", email: "contato@fluta.com.br")
    
    #pedidos usuario 1
    order1 = Order.create!(user: user1, warehouse: warehouse2, supplier: supplier1, date_delivery: 5.day.from_now)
    order2 = Order.create!(user: user1, warehouse: warehouse2, supplier: supplier2, date_delivery: 5.day.from_now)
    #pedidos usuario 2
    order3 = Order.create!(user: user2, warehouse: warehouse1, supplier: supplier2, date_delivery: 5.day.from_now)
    
    #Act
    login_as(user1)
      visit root_path
      within('nav') do
        click_on "Meus Pedidos"
      end
    
    #Assert
      expect(page).to have_content order1.code
      expect(page).to have_content order2.code
      expect(page).not_to have_content order3.code
    end
end