require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com login e senha corretos' do
        #Arrange
        user = User.create!(name: 'Matheus', email: 'matheus@gmail.com', password: 'senha1234')
        #Act
        visit root_path
        click_on 'Entrar'
        within('main form') do
            fill_in 'E-mail', with:'matheus@gmail.com'
            fill_in 'Senha', with: 'senha1234'
            click_on 'Login'
        end
        #Assert
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
        within('nav') do 
            expect(page).to have_content user.name
        end
        expect(page).to have_content 'Login efetuado com sucesso.'
        expect(page).to have_content 'Matheus - matheus@gmail.com'
    end
    
    it 'com login e senha incorretos' do
        #Arrange
        User.create!(name: 'Matheus', email: 'matheus@gmail.com', password: 'senha1234')
        #Act
        visit root_path
        click_on 'Entrar'
        within('main form') do
            fill_in 'E-mail', with:'matheus@gmail.com'
            fill_in 'Senha', with: 'senha123456789'
            click_on 'Login'
        end
        #Assert
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
        expect(page).not_to have_content 'Matheus - matheus@gmail.com'
        expect(page).to have_content 'E-mail ou senha inválidos.'
    end
    
    it 'e faz logout' do
        #Arrange
        User.create!(email: 'matheus@gmail.com', password: 'senha1234')
        #Act
        visit root_path
        click_on 'Entrar'
        within('main form') do
            fill_in 'E-mail', with:'matheus@gmail.com'
            fill_in 'Senha', with: 'senha1234'
            click_on 'Login'
        end
        click_on 'Sair'
        #Assert
        expect(page).to have_content 'Logout efetuado com sucesso.'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
        expect(page).not_to have_link 'matheus@gmail.com'
    end
end