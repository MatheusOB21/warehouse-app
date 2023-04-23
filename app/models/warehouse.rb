class Warehouse < ApplicationRecord
    validates :name,:description, :code, :adress, :city, :cep, :area, presence: true
    validates :code, uniqueness: true
end
