class StockProductsController < ApplicationController
  def create
    stock_product = StockProduct.new(stock_product_params)

    if stock_product.save
      render json: { stock_product: stock_product }, status: 201
    else
      render json: { errors: stock_product.errors }, status: 422
    end
  end

  def update
    begin
      stock_product = StockProduct.find(params[:id])
      if StockProductCreator.call(stock_product: stock_product, quantity: stock_product_update_params)
        render json: { stock_product: stock_product }, status: 200
      else
        render json: { errors: "Invalid quantity" }, status: 422
      end
    rescue
      head 404
    end
  end

  private
  
  def stock_product_params
    params.require(:stock_product).permit(:store_id, :product_id, :quantity)
  end

  def stock_product_update_params
    update_params = params.require(:stock_product).permit(:quantity)
    update_params[:quantity] = update_params[:quantity]
  end
end
