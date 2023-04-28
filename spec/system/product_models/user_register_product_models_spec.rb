require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'admin', email: 'admin@gmail.com', password:'admin12345') 
        supplier1 = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')  
        supplier2 = Supplier.create!(brand_name: 'Apple', corporate_name: 'Apple Inc.', registration_number: '15467845681236', full_address: 'Av Maizena, 70000', city: 'São Paulo', state: 'SP', email: 'ouvidoria@apple.com.br')  
        
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar novo modelo'
        fill_in 'Nome', with: 'Smart TV LED 43" 4K UHD'
        fill_in 'Peso', with: 10_000
        fill_in 'Largura', with: 50 
        fill_in 'Altura', with: 70
        fill_in 'Profundidade', with: 15
        fill_in 'SKU', with: 'TV40LED-SAMS-XPTO157'
        select 'Samsung', from: 'Fornecedor'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
        expect(page).to have_content 'Smart TV LED 43" 4K UHD'
        expect(page).to have_content 'Fornecedor: Samsung'
        expect(page).to have_content 'TV40LED-SAMS-XPTO157'
        expect(page).to have_content 'Dimensão: 50cm x 70cm x 15cm'
        expect(page).to have_content 'Peso: 10000g'
    end

    it 'e todos os campos são obrigatórios' do
        #Arrange 
          user = User.create!(name: 'admin', email: 'admin@gmail.com', password:'admin12345') 
          supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br') 
        #Act
          login_as(user)
          visit root_path
          click_on 'Modelos de Produtos'
          click_on 'Cadastrar novo modelo'
          fill_in 'Nome', with: 'Smart TV LED 43" 4K UHD'
          fill_in 'Peso', with: ''
          fill_in 'Largura', with: 50 
          fill_in 'Altura', with: 70
          fill_in 'Profundidade', with: 15
          fill_in 'SKU', with: ''
          select 'Samsung', from: 'Fornecedor'
          click_on 'Enviar' 
        
        #Assert
          expect(page).to have_content 'Modelo de produto não cadastrado.'
    end
end