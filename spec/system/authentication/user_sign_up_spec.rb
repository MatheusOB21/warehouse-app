require 'rails_helper'

describe 'Usuário se registra' do
    it 'com sucesso' do
        #Arrange

        #Act
        visit root_path
        click_on 'Entrar'
        click_on 'Criar conta'
        fill_in 'Nome', with: 'Matheus'
        fill_in 'E-mail', with: 'matheus@gmail.com'
        fill_in 'Senha', with: 'senha1234'
        fill_in 'Confirme sua senha', with: 'senha1234'
        click_on 'Criar conta'
        #Assert
        expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
        expect(page).to have_content 'matheus@gmail.com'
        expect(page).to have_button 'Sair'
        user = User.last 
        expect(user.name).to eq 'Matheus'
    end
end