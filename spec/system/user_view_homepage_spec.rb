require 'rails_helper'

describe 'Usuario visita a tela inicial' do
    it 'e vê o nome da app' do
        # Arrange
        user = User.create!(name: 'Jose', email: 'jose@gmail.com', password: '123456789')
        # Act
        login_as(user)
        visit(root_path)

        # Assert    
        expect(page).to have_content('Galpões & Estoque')
    end

    it 'e vê os galpões cadastrados' do
        # Arrange
        user = User.create!(name: 'Jose', email: 'jose@gmail.com', password: '123456789')
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
        Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, adress: "Avenida das Livraria, 2500", cep: '71000-000', description: 'Galpão do Maceio')
        # Act
        login_as(user)
        visit(root_path)
        
        # Assert
        expect(page).not_to have_content('Não existem galpões cadastrados')
        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000 m2')
        
        expect(page).to have_content('Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio')
        expect(page).to have_content('50000 m2')
    end

    it 'e não existem galpões cadastrados' do
        #Arrange
        user = User.create!(name: 'Jose', email: 'jose@gmail.com', password: '123456789')
        #Act
        login_as(user)
        visit(root_path)
        #Assert
        expect(page).to have_content('Não existem galpões cadastrados')
    end
end