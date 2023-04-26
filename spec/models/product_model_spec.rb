require 'rails_helper'

RSpec.describe ProductModel, type: :model do
    describe '#valid?' do
        it 'false when name is empty' do
          #Arrange 
            supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br') 
            product_model = ProductModel.new(name:'', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
          #Act
            result = product_model.valid?
          
          #Assert
            expect(result).to eq(false)
        end
        it 'false when sku is empty' do
          #Arrange 
            supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br') 
            product_model = ProductModel.new(name:'TV 40" 4k UHD', weight: 8000, width: 70, height: 45, depth:10, sku: '', supplier: supplier)
          #Act
            result = product_model.valid?
          
          #Assert
            expect(result).to eq(false)
        end
        it 'false when sku already is in use' do
          #Arrange 
            supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br') 
            product_model_1 = ProductModel.new(name:'TV 40" 4k UHD', weight: 8000, width: 70, height: 45, depth:10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
            product_model_2 = ProductModel.new(name:'TV 40" 8k UHD', weight: 9000, width: 80, height: 55, depth:20, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
          #Act
            result = product_model_2.valid?
          #Assert
            expect(result).to eq(false)
        end
        it 'false when weight <= 0' do
          #Arrange 
            supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronic LTDA', registration_number: '12345678914563', full_address: 'Av das Liberdades, 2000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br') 
            product_model = ProductModel.new(name:'TV 40" 4k UHD', weight: -8000, width: 70, height: 45, depth:10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
          #Act
            result = product_model.valid?
          
          #Assert
            expect(result).to eq(false)
        end
    end
end


