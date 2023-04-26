require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
    it 'a partir do menu' do
        #Arrange

        #Act
        visit root_path
        within('nav') do
          click_on 'Modelos de Produtos'
        end
        #Assert
        expect(current_path).to eq product_models_path
    end

    it 'com sucesso' do
        #Arrange
          s = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')  
          
          ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV32LED-SAMSU-XPTO90', supplier: s)
          ProductModel.create!(name:'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth:5, sku: 'SOU71S-SAMSU-NOIZ777', supplier: s)
        #Act
        visit root_path
        within('nav') do
          click_on 'Modelos de Produtos'
        end
        #Assert
          expect(page).to have_content 'TV 32'
          expect(page).to have_content 'TV32LED-SAMSU-XPTO90'
          expect(page).to have_content 'Samsung'
          expect(page).to have_content 'SoundBar 7.1 Surround'
          expect(page).to have_content 'SOU71S-SAMSU-NOIZ777'
          expect(page).to have_content 'Samsung'
    end

    it 'mas não existem modelos cadastrados' do
      #Arrange
      
      #Act
      visit root_path
      click_on 'Modelos de Produtos'
      #Assert
      expect(page).to have_content 'Nenhum modelo de produto cadastrado'
    end
end