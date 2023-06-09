require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', adress: 'Endereço', cep: '24000-000', city: 'Rio', area: 1000, description: 'Algo')
        #Act
        #Assert
        expect(warehouse.valid?).to eq(false)
      end
      it 'false when code is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', adress: 'Endereço', cep: '24000-000', city: 'Rio', area: 1000, description: 'Algo')
        #Act
        #result = warehouse.valid?
        #Assert
        expect(warehouse).not_to be_valid
      end
      it 'false when adress is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'Rio', adress: '', cep: '24000-000', city: 'Rio', area: 1000, description: 'Algo')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when cep is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'Rio', adress: 'Endereço', cep: '', city: 'Rio', area: 1000, description: 'Algo')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when city is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'Rio', adress: 'Endereço', cep: '24000-000', city: '', area: 1000, description: 'Algo')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when area is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'Rio', adress: 'Endereço', cep: '24000-000', city: 'Rio', area: '' , description: 'Algo')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when description is empty' do
      #Arrange
      warehouse = Warehouse.new(name: 'Rio', code: 'Rio', adress: 'Endereço', cep: '24000-000', city: 'Rio', area: 1000 , description: '')
      #Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq(false)
      end
    end
    
    it 'false when code is already in use' do
    #Arrange
      warehouse1 = Warehouse.create!(name: 'Rio de Amarelho', code: 'RIO', adress: 'Rua Capixaba, 50000', cep: '24000-000', city: 'Rio', area: 1000, description: 'Alguma coisa')
      warehouse2 = Warehouse.new(name: 'São Paulinho', code: 'RIO', adress: 'Rua Amazonas, 3000', cep: '62000-000', city: 'São Paulo', area: 2000, description: 'Alguma coisa de novo')
    #Act
      result = warehouse2.valid?
    #Assert
      expect(result).to eq(false)
    end

    it 'false when cep is invalid format' do
      #Arrange
      warehouse1 = Warehouse.create!(name: 'Rio de Amarelho', code: 'RIO', adress: 'Rua Aline, 2000', cep: '24000-000', city: 'Rio', area: 1000, description: 'Alguma coisa')
      warehouse2 = Warehouse.new(name: 'São Paulinho', code: 'SAO', adress: 'Rua Fulano, 2000', cep: '6200-0000', city: 'São Paulo', area: 2000, description: 'Alguma coisa de novo')
      #Act
      result = warehouse2.valid?
      #Assert
      expect(result).to eq(false)
    end

  end

  describe '#description_full' do
    it 'exibe nome e código' do
      #Arrange
      w = Warehouse.new(name: "Galpão Espírito Santos", code: 'GES')
      #Act
      result = w.description_full
      #Assert
      expect(result).to eq('GES - Galpão Espírito Santos')
    end
  end
end
