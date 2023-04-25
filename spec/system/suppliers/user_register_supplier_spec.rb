require 'rails_helper' 

describe 'Usuário cadastra um novo fornecedor' do
    
    it 'a partir da tela inicial' do
        #Arrange

        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar novo fornecedor'
        
        #Assert
        expect(page).to have_field('Nome fantasia')
        expect(page).to have_field('Razão Social')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')
        expect(page).to have_field('Email')

    end

    it 'com sucesso' do
        #Arrange

        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar novo fornecedor'
        fill_in 'Nome fantasia', with: 'Campusoft'
        fill_in 'Razão Social', with: 'Campus Rub'
        fill_in 'CNPJ', with: '15267823451278'
        fill_in 'Endereço', with: 'Avenida Profissional, 2034'
        fill_in 'Cidade', with: 'Manaus'
        fill_in 'Estado', with: 'AM'
        fill_in 'Email', with: 'contato@campus.com.br'
        click_on 'Enviar'
        
        #Assert
        expect(current_path).to eq suppliers_path
        expect(page).to have_content('Fornecedor registrado com sucesso!')
        expect(page).to have_content('Fornecedores')
        expect(page).to have_content('Campusoft')
        expect(page).to have_content('Manaus - AM')
    end

    it 'sem sucesso' do
        #Arrange

        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar novo fornecedor'
        fill_in 'Nome fantasia', with: 'Campusoft'
        fill_in 'Razão Social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'Cidade', with: 'Manaus'
        fill_in 'Estado', with: 'AM'
        fill_in 'Email', with: 'contato@campus.com.br'
        click_on 'Enviar'
        
        #Assert
        expect(page).to have_content('Fornecedor não cadastrado!')
        expect(page).to have_content('Razão Social não pode ficar em branco')                  
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Endereço não pode ficar em branco')
    end
end