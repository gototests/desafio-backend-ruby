class Product < ApplicationRecord
  has_many :stores, through: :stock_products

  validates_presence_of :name, :price
end
