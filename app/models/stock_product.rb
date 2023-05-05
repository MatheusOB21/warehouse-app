class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model

  before_validation :generate_serial, on: :create

  private
  
  def generate_serial
    self.serial = SecureRandom.alphanumeric(20).upcase
  end

end
