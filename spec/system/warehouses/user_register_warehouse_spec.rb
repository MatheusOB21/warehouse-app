require 'rails_helper'

describe 'Usuario cadastra um galpão' do
    it 'a partir da tela inicial' do
        #Arrange
        user = User.create!(name: 'Jose', email: 'jose@gmail.com', password: '123456789')

        #Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar Galpão'
        
        #Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Descrição')
        expect(page).to have_field('Código')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Área')
    end
    
    it 'com sucesso' do 
        #Arrange
        user = User.create!(name: 'Jose', email: 'jose@gmail.com', password: '123456789')

        #Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: 'Rio de Janeiro'
        fill_in 'Descrição', with: 'Galpão da zona 42, ninguém sabe o que tem lá'
        fill_in 'Código', with: 'RJN'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'Endereço', with: 'Avenida Das Palmeiras, 2000'
        fill_in 'CEP', with: '61000-000'
        fill_in 'Área', with: '32000'
        click_on 'Enviar'

        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão cadastrado com sucesso!'
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content 'RJN'
        expect(page).to have_content '32000 m2'
    end
    it 'com dados incompletos' do
        #Arrange
        user = User.create!(name: 'Jose', email: 'jose@gmail.com', password: '123456789')

        #Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Código', with: 'RJN'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'Endereço', with: 'Avenida Das Palmeiras, 2000'
        fill_in 'CEP', with: '61000-000'
        fill_in 'Área', with: '32000'
        click_on 'Enviar'
        #Assert 
        expect(page).to have_content 'Galpão não cadastrado!'
        expect(page).to have_content "Nome não pode ficar em branco"
        expect(page).to have_content "Descrição não pode ficar em branco"
    end
end