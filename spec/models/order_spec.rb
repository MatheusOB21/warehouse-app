require 'rails_helper'

RSpec.describe Order, type: :model do
  
  describe '#valid?' do
    it 'precisa ter um código' do
      #Arrange
      user = User.create!(name: 'Flavio', email: 'flavio@funcionario.com.br', password: 'flaviosoueu123')
      warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
      supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
      
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, date_delivery: "2024-01-01")

      #Act
      result = order.valid?
      #Assert
      expect(result).to be true
    end
    
    it 'data de entrega não pode ser do passado' do
      #Arrange
      order = Order.new(date_delivery: 5.day.ago)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :date_delivery).to be true
      expect(order.errors[:date_delivery]).to include(" deve ser futura.")
    end
    
    it 'data de entrega não pode ser a atual(hoje)' do
      #Arrange
      order = Order.new(date_delivery: Date.today)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :date_delivery).to be true
      expect(order.errors[:date_delivery]).to include(" deve ser futura.")
    end
    
    it 'data de entrega dever ser futura' do
      #Arrange
      order = Order.new(date_delivery: 5.day.from_now)
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :date_delivery).to be false
    end
    
    it 'data de entrega deve ser obrigado a preencher' do
      #Arrange
      order = Order.new(date_delivery: "")
      #Act
      order.valid?
      #Assert
      expect(order.errors.include? :date_delivery).to be true
    end

  end
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      #Arrange 
        user = User.create!(name: 'Flavio', email: 'flavio@funcionario.com.br', password: 'flaviosoueu123')
        warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
        supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
        
        order = Order.new(user: user, warehouse: warehouse, supplier: supplier, date_delivery: "2024-01-01")
      
        #Act
        order.save!
        result = order.code

      #Assert
        expect(result).not_to be_empty
        expect(result.length).to eq 10
    end

    it 'e o código é unico novo pedido' do
      #Arrange 
        user = User.create!(name: 'Flavio', email: 'flavio@funcionario.com.br', password: 'flaviosoueu123')
        warehouse = Warehouse.create!(name: 'Rio Gate', code: 'RDU', city: 'Rio de Janeiro', area: 60_000, adress: "Avenida das Palmeiras, 2500", cep: '61000-000', description: 'Galpão do Rio de Janeiro')
        supplier = Supplier.create!(corporate_name: "Mistery Inc", brand_name: "Mistery", registration_number:"15225845612345", full_address: "Avenida Flamingos, 156", city: "New Orleans", state: "WS", email: "contato@mistery.com.br")
        
        order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, date_delivery: "2024-01-01")
        order2 = Order.new(user: user, warehouse: warehouse, supplier: supplier, date_delivery: "2025-01-01")
      
        #Act
        order2.save!
        result = order2.code
        user.user_and_email

      #Assert
        expect(result).not_to eq order1.code
    end
  end
end
