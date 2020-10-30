class StockProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
