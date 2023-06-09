class Warehouse < ApplicationRecord
    validates :name,:description, :code, :adress, :city, :cep, :area, presence: true
    validates :code, uniqueness: true
    validates :cep, length: { is: 9 }
    validates :cep , format: { with: /\d{5}-\d{3}/ }

    has_many :stock_product

    def description_full
        "#{code} - #{name}"
    end
end
