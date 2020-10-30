class Store < ApplicationRecord
  has_many :products, through: :stock_products

  validates_presence_of :name
end
