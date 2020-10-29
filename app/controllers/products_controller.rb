class ProductsController < ApplicationController
  def show
    begin
      product = Product.find(params[:id])
      render json: { product: product }, status: 200
    rescue
      head 404
    end
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: { product: product }, status: 201
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def update
    begin
      product = Product.find(params[:id])

      if product.update(product_params)
        render json: { product: product }, status: 200
      else
        render json: { errors: product.errors }, status: 422
      end
    rescue
      head 404
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
