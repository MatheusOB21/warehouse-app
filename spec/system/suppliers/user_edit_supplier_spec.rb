require 'rails_helper'

describe 'Usuário consegue editar o fornecedor' do
    it 'a partir da view fornecedores' do
        #Arrange
          Supplier.create!(corporate_name: "Junior Inc.", brand_name: "Junior Clothes", registration_number:"17814512345786", full_address: "Rua Rosa, 143", city: "Rio de Janeiro", state: "RJ", email: "contato@junior.com.br")
        #Act
          visit root_path
          click_on "Fornecedores"
          click_on "Junior Clothes"
          click_on "Editar"
        #Assert
          expect(page).to have_field('Nome fantasia', with: 'Junior Clothes')
          expect(page).to have_field('Razão Social', with: 'Junior Inc.')
          expect(page).to have_field('CNPJ', with: '17814512345786')
          expect(page).to have_field('Endereço', with: 'Rua Rosa, 143')
          expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
          expect(page).to have_field('Estado', with: 'RJ')
          expect(page).to have_field('Email', with: 'contato@junior.com.br')
    end
    it 'com sucesso' do
        #Arrange
          supplier = Supplier.create!(corporate_name: "Junior Inc.", brand_name: "Junior Clothes", registration_number:"17814512345786", full_address: "Rua Rosa, 143", city: "Rio de Janeiro", state: "RJ", email: "contato@junior.com.br")
        #Act
          visit root_path
          click_on "Fornecedores"
          click_on "Junior Clothes"
          click_on "Editar"
          
          fill_in 'Nome fantasia', with: 'Junior Roupas'
          fill_in 'Razão Social', with: 'Junior LTDA'
          fill_in 'Endereço', with: 'Avenida São Pinheiro, 2000'
          
          click_on "Enviar"
        #Assert
          expect(current_path).to eq supplier_path(supplier.id)
          expect(page).to have_content('Fornecedor atualizado com sucesso!')
          expect(page).to have_content('Fornecedores')
          expect(page).to have_content('Junior Roupas')
          expect(page).not_to have_content('Junior Clothes')
    end

    it 'sem sucesso' do
      #Arrange
        supplier = Supplier.create!(corporate_name: "Junior Inc.", brand_name: "Junior Clothes", registration_number:"17814512345786", full_address: "Rua Rosa, 143", city: "Rio de Janeiro", state: "RJ", email: "contato@junior.com.br")
      #Act
        visit root_path
        click_on "Fornecedores"
        click_on "Junior Clothes"
        click_on "Editar"
        
        fill_in 'Nome fantasia', with: ''
        fill_in 'Razão Social', with: 'Junior LTDA'
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'Cidade', with: 'São Paulo'
        fill_in 'Estado', with: 'SP'
        fill_in 'Email', with: 'sac@juniorltd.com.br'
        
        click_on "Enviar"
      #Assert
      expect(page).to have_content('Fornecedor não atualizado!')
      expect(page).to have_content('Nome fantasia não pode ficar em branco')                  
      expect(page).to have_content('CNPJ não pode ficar em branco')
      expect(page).to have_content('Endereço não pode ficar em branco')
    end
end