require 'rails_helper'

RSpec.describe "StockProducts", type: :request do
  fixtures(:product, :store, :stock_product)

  describe 'POST /stock_products' do
    before do
      post '/stock_products', params: { stock_product: stock_products_params }
    end

    context 'when params are valid' do
      let(:stock_products_params) do
        {
          product_id: 2,
          store_id: 2,
          quantity: 100
        }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the created stock' do
        expect(json_body[:stock_product]).to be_present
        expect(json_body[:stock_product][:quantity]).to eq(100)
        expect(json_body[:stock_product][:store_id]).to be_present
        expect(json_body[:stock_product][:product_id]).to be_present
      end
    end

    context 'when params are invalid' do
      let(:stock_products_params) do
        {
          product_id: 10,
          store_id: 19,
          quantity: 100
        }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors message' do
        expect(json_body[:errors]).to be_present
      end

      context 'and quantity is lower than 0' do
        let(:stock_products_params) do
          {
            product_id: 2,
            store_id: 2,
            quantity: -10
          }
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns errors message' do
          expect(json_body[:errors][:quantity]).to include("must be greater than or equal to 0")
        end
      end
    end
  end

  describe 'PUT /stock_products/:id' do
    let(:stock_product_id) { 1 }

    before do
      put "/stock_products/#{stock_product_id}",
        params: { stock_product: stock_product_params }
    end

    context 'when params are valid' do
      context 'and adds item quantity from stock' do
        let(:stock_product_params) do
          {
            quantity: 200
          }
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns the stock product updated' do
          expect(json_body[:stock_product][:quantity]).to eq(210)
        end
      end

      context 'and subtracs item quantity from stock' do
        let(:stock_product_params) do
          {
            quantity: -5
          }
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns the stock product updated' do
          expect(json_body[:stock_product][:quantity]).to eq(5)
        end
      end
    end
  end
end
