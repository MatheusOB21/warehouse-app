require "rails_helper"

describe 'Usuário consegue ver os detalhes de um fornecedor' do
    it 'com sucesso' do
      #Arrange
        Supplier.create!(corporate_name: "Apple Inc.", brand_name: "Apple", registration_number:"90256745611345", full_address: "Rua Law, 256", city: "São Paulo", state: "SP", email: "contato@apple.com.br")
        user = User.create!(name: 'admin', email: 'admin@gmail.com', password:'admin12345') 
      #Act
        login_as(user)
        visit root_path
        click_on 'Fornecedores'
        click_on 'Apple'
      
      #Assert
        expect(page).to have_content('Fornecedor: Apple Inc.')
        expect(page).to have_content('Razão: Apple')
        expect(page).to have_content('CNPJ: 90256745611345')
        expect(page).to have_content('Endereço: Rua Law, 256')
        expect(page).to have_content('Cidade: São Paulo')
        expect(page).to have_content('Estado: SP')
        expect(page).to have_content('Email: contato@apple.com.br')
    end

    it 'e consegue voltar para a tela inicial' do
      #Arrange
        Supplier.create!(corporate_name: "Mistery SA", brand_name: "Scooby-doo", registration_number:"90256745611345", full_address: "Rua Law, 256", city: "Salvador", state: "BA", email: "contato@misterysa.com.br")
        user = User.create!(name: 'admin', email: 'admin@gmail.com', password:'admin12345') 
      
      #Act
        login_as(user)
        visit root_path
        click_on 'Fornecedores'
        click_on 'Scooby-doo'
        click_on 'Voltar'

      #Assert
        expect(current_path).to eq suppliers_path
        expect(page).to have_content('Fornecedores')
        expect(page).to have_content('Scooby-doo')
        expect(page).to have_content('Salvador - BA')
    end
end