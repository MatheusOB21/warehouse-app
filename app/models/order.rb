class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  has_many :order_items
  has_many :product_models, through: :order_items

  enum :status, pending: 0, delivered: 1, canceled: 2

  validates :code, :date_delivery, presence: true

  before_validation :generate_code, on: :create

  validate :date_delivery_is_future

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def date_delivery_is_future 
    if self.date_delivery.present? && self.date_delivery <= Date.today
      self.errors.add(:date_delivery, " deve ser futura.")
    end
  end

end
