require 'rails_helper'

describe 'Usuário edita um galpão' do
    it 'a partir da tela detalhes' do
        #Arrange
        Warehouse.create!(name: 'Rio Gate', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
        #Act
        visit root_path
        click_on 'Rio Gate'
        click_on 'Editar'
        #Assert
        expect(page).to have_content('Editar galpão:')

        expect(page).to have_field('Nome', with: 'Rio Gate')
        
        expect(page).to have_field('Descrição', with: 'Galpão do Rio de Janeiro')
        
        expect(page).to have_field('Código', with: 'SDU')
        
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        
        expect(page).to have_field('Endereço', with: 'Avenida das Palmeiras, 2500')
        
        expect(page).to have_field('CEP', with:'61000-000')

        expect(page).to have_field('Área', with: '60000')
    end
    it 'com sucesso' do
     #Arrange
     Warehouse.create!(name: 'Rio Gate', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
     
     #Act
     visit root_path
     click_on 'Rio Gate'
     click_on 'Editar'
     fill_in 'Nome', with: "Rio's Gates"
     fill_in 'Código', with: 'RGT'
     fill_in 'Endereço', with: 'Avenida das Lancheiras, 2300'
     click_on 'Enviar'
     
     #Assert
    expect(page).to have_content("Galpão atualizado!")
    expect(page).to have_content("Rio's Gates")
    expect(page).to have_content('RGT')
    expect(page).to have_content('Avenida das Lancheiras, 2300')
    end
    
    it 'sem sucesso' do
     #Arrange
     Warehouse.create!(name: 'Rio Gate', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
     
     #Act
     visit root_path
     click_on 'Rio Gate'
     click_on 'Editar'
     fill_in 'Nome', with: ''
     fill_in 'Código', with: ''
     fill_in 'Endereço', with: ''
     click_on 'Enviar'

     #Assert
     expect(page).to have_content 'Galpão não cadastrado!'
     expect(page).to have_content 'Nome não pode ficar em branco'
     expect(page).to have_content 'Código não pode ficar em branco'
     expect(page).to have_content 'Endereço não pode ficar em branco'
    end
end