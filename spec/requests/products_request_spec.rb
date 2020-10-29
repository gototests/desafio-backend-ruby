require 'rails_helper'

RSpec.describe 'Products', type: :request do
  fixtures(:product)

  describe 'GET /product/:id' do
    context 'when product exists' do
      before { get "/products/#{1}" }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the product' do
        expect(json_body[:product]).to be_present
        expect(json_body[:product][:id]).to eq(1)
      end
    end

    context 'when product does not exists' do
      before { get '/products/XXXXXXX' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /products' do
    before do
      post '/products', params: { product: product_params }
    end

    context 'when params are valid' do
      let(:product_params) do
        { name: 'Cable', price: 10000 }
      end

      it 'returns stauts code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the created product' do
        expect(json_body[:product]).to be_present
        expect(json_body[:product][:name]).to eq(product_params[:name])
      end
    end

    context 'when params are invalid' do
      let(:product_params) do
        { name: nil }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors message' do
        expect(json_body[:errors]).to be_present
      end
    end
  end

  describe 'PUT /products/:id' do
    let(:product_id) { 1 }

    before do
      put "/products/#{product_id}", params: { product: product_params }
    end

    context 'when params are valid' do
      let(:product_params) do
        { price: 20000 }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns updated product' do
        expect(json_body[:product][:price]).to eq(product_params[:price])
      end
    end

    context 'when params are invalid' do
      let(:product_params) do
        { price: nil }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors message' do
        expect(json_body[:errors]).to be_present
        expect(json_body[:errors][:price]).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /products/:id' do
    let(:product_id) { 1 }
    before { delete "/products/#{product_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
