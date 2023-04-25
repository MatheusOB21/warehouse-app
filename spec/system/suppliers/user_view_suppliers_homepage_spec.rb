require 'rails_helper'

describe 'Usuario vê os fornecedores' do
    it 'a partir de um menu' do
        #Arrange

        #Act
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end
        #Assert
        expect(current_path).to eq(suppliers_path)
    end

    it 'com sucesso' do
        #Arrange
        Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
        Supplier.create!(corporate_name: "Anakin LTDA", brand_name: "Anakin", registration_number:"21456790817654", full_address: "Avenida Darks,1235", city: "Paredes", state: "PT", email: "contato@anakin.com.br")
        #Act
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end
        #Assert
        expect(page).to have_content('Fornecedores')
        expect(page).to have_content('Mistery')
        expect(page).to have_content('New Orleans - WS')
        expect(page).to have_content('Anakin')
        expect(page).to have_content('Paredes - PT')
    end
    it 'mas não possui fornecedores cadastrados' do
        #Arrange

        #Act
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end  
        #Assert 
        expect(page).to have_content('Não existem fornecedores cadastrados!') 
    end
end