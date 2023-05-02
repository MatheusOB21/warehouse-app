require 'rails_helper'

describe 'Usuário cadastra um pedido' do
    it 'com sucesso' do
    #Arrange
      user = User.create!(name: 'Flavio', email: 'flavio@funcionario.com.br', password: 'flaviosoueu123')
      
                  Warehouse.create!(name: 'Ceara Gate', code: 'CFZ', city: 'Maceio', area: 50_000, adress: "Avenida das Livraria, 2500", cep: '71000-000', description: 'Galpão do Maceio')
      warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
                  
                  Supplier.create!(corporate_name: "Anakin LTDA", brand_name: "Anakin", registration_number:"21456790817654", full_address: "Avenida Darks,1235", city: "Paredes", state: "PT", email: "contato@anakin.com.br")
      supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
    
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDFGHIJK')
    #Act
      login_as(user)
      visit root_path
      click_on ('Cadastrar novo pedido')
      select 'RDU - Rio Gate', from: 'Galpão'
      select supplier.corporate_name, from: 'Fornecedor'
      fill_in 'Data de entrega', with: '20/12/2024'
      click_on 'Enviar'
    #Assert
      expect(page).to have_content 'Pedido feito com sucesso'
      expect(page).to have_content 'Número do pedido: ABCDFGHIJK'
      expect(page).to have_content 'Fornecedor responsável: Mistery Inc'
      expect(page).to have_content 'Galpão destino: RDU - Rio Gate'
      expect(page).to have_content 'Usuário responsável: Flavio'
      expect(page).to have_content 'Email do responsável: <flavio@funcionario.com.br>'
      expect(page).to have_content 'Data de entrega: 20/12/2024'
      expect(page).to have_content 'Status do pedido: Pendente'
      
      expect(page).not_to have_content 'Fornecedor: Anakin LTDA'
      expect(page).not_to have_content 'Galpão destinado: Ceara Gate'
    end
end