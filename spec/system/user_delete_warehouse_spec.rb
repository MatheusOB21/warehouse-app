require 'rails_helper'

describe 'Usuário deleta um warehouse' do
    it 'com sucesso' do
    #Arrange
      Warehouse.create!(name: 'Pernambuco Gate', code: 'RGT', city: 'Pernambuco', area: 60_000, adress: "Travessa São José, 2500", cep: '61000-000', description: 'Galpão de Pernambuco')
    #Act
      visit root_path
      click_on 'Pernambuco Gate'
      click_on 'Remover'
    #Assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Galpão removido com sucesso'
      expect(page).not_to have_content 'Pernambuco Gate'
      expect(page).not_to have_content 'RGT'
    end
    
    it 'e não apaga outros galpões'  do
    #Arrange
      first_w = Warehouse.create!(name: 'Pernambuco Gate', code: 'PGT', city: 'Pernambuco', area: 60_000, adress: "Travessa São José, 2500", cep: '61000-000', description: 'Galpão de Pernambuco')
      second_w = Warehouse.create!(name: 'Recife Gate', code: 'RTT', city: 'Arcoverde', area: 40_000, adress: "Travessa Cuba, 1500", cep: '61200-000', description: 'Galpão dde Recife, no porto')
    #Act
      visit root_path
      click_on 'Pernambuco Gate'
      click_on 'Remover'
    #Assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Galpão removido com sucesso'
      expect(page).to have_content 'Recife Gate'
      expect(page).not_to have_content 'Pernambuco Gate'
    end
end