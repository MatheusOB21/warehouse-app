require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#user_and_email' do
    it '' do
      #Arrange
        u = User.new(name: 'Maria', email: 'maria@bol.email.com')
      #Act
        result = u.user_and_email
      #Assert
      expect(result).to eq('Maria - maria@bol.email.com')
    end
  end
end
