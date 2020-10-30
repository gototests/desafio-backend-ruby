class StockProductCreator < ApplicationService
  attr_reader :stock_product, :quantity

  def initialize(args)
    @stock_product = args[:stock_product]
    @quantity = args[:quantity].to_i || 0
  end

  def call
    ActiveRecord::Base.transaction do
      stock_product.quantity += quantity
      stock_product.save
    end
  end
end
