class Warehouse < ApplicationRecord
    validates :name,:description, :code, :adress, :city, :cep, :area, presence: true
end