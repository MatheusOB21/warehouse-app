require "rails_helper"

describe 'Usuário consegue ver os detalhes de um fornecedor' do
    it 'com sucesso' do
      #Arrange
      Supplier.create!(corporate_name: "Mistery SA", brand_name: "Scooby", registration_number:"90256745611345", full_address: "Rua Law, 256", city: "Salvador", state: "BA", email: "contato@misterysa.com.br")
      
      #Act
      visit root_path
      click_on 'Fornecedores'
      click_on 'Scooby'
      
      #Assert
      expect(page).to have_content('Fornecedor: Mistery SA')
      expect(page).to have_content('Razão: Scooby')
      expect(page).to have_content('CNPJ: 90256745611345')
      expect(page).to have_content('Endereço: Rua Law, 256')
      expect(page).to have_content('Cidade: Salvador')
      expect(page).to have_content('Estado: BA')
      expect(page).to have_content('Email: contato@misterysa.com.br')
    end

    it 'e consegue voltar para a tela inicial' do
      #Arrange
      Supplier.create!(corporate_name: "Mistery SA", brand_name: "Scooby", registration_number:"90256745611345", full_address: "Rua Law, 256", city: "Salvador", state: "BA", email: "contato@misterysa.com.br")

      #Act
      visit root_path
      click_on 'Fornecedores'
      click_on 'Scooby'
      click_on 'Voltar'

      #Assert
      expect(current_path).to eq suppliers_path
      expect(page).to have_content('Fornecedores:')
      expect(page).to have_content('Scooby')
      expect(page).to have_content('Salvador - BA')

    end
end