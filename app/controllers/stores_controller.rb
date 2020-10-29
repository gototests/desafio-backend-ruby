class StoresController < ApplicationController
  def show
    begin
      store = Store.find(params[:id])
      render json: { store: store }, status: 200
    rescue
      head 404
    end
  end

  def create
    store = Store.new(store_params)

    if store.save
      render json: { store: store }, status: 201
    else
      render json: { errors: store.errors }, status: 422
    end
  end

  def update
    begin
      store = Store.find(params[:id])

      if store.update(store_params)
        render json: { store: store }, status: 200
      else
        render json: { errors: store.errors }, status: 422
      end
    rescue
      head 404
    end
  end

  def destroy
    Store.find(params[:id]).destroy
    head 204
  end

  private 

  def store_params
    params.require(:store).permit(:name, :address)
  end
end
