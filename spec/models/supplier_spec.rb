require 'rails_helper'

RSpec.describe Supplier, type: :model do
    describe "#valid" do
        context "presence" do
            it "false when corporate is empty" do
              #Arrange
              supplier = Supplier.new(corporate_name: "", brand_name: "Scooby", registration_number:"15415678921435", full_address: "Rua Law, 256", city: "Salvador", state: "BA", email: "contato@misterysa.com.br")
              #Act
              #Assert
              expect(supplier.valid?).to eq(false)
            end
            
            it "false when brand_name is empty" do
              #Arrange
              supplier = Supplier.new(corporate_name: "Mistery SA", brand_name: "", registration_number:"15415678921435", full_address: "Rua Law, 256", city: "Salvador", state: "BA", email: "contato@misterysa.com.br")
              #Act
              #Assert
              expect(supplier.valid?).to eq(false)
            end
        end

        it "false when registration_number is already in use" do
          #Arrange
            supplier1 = Supplier.create!(corporate_name: "Cargo LTA", brand_name: "Cargueiro", registration_number:"90256745611345", full_address: "Rua Law, 256", city: "Fortaleza", state: "CE", email: "contato@misterysa.com.br")
            supplier2 = Supplier.new(corporate_name: "Capanga SA", brand_name: "Monster", registration_number:"90256745611345", full_address: "Rua Luiz XV, 280", city: "São Luis", state: "MA", email: "contato@capanga.com.br")
          #Act
            result = supplier2.valid?
          #Assert
            expect(result).to eq(false)
        end
    end
end
