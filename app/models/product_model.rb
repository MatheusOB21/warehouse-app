class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, :weight, :width, :height, :depth, :supplier, presence: true
  validates :sku, length: {is: 20}
  validates :weight, :width, :height, :depth, numericality:{ greater_than: 0}

  has_many :order_items
  has_many :orders, through: :order_items
end
