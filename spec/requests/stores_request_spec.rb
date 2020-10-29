require 'rails_helper'

RSpec.describe "Stores", type: :request do
  fixtures(:store)

  describe 'GET /stores/:id' do
    context 'when store exists' do
      before { get "/stores/#{1}" }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the store' do
        expect(json_body[:store]).to be_present
        expect(json_body[:store][:id]).to eq(1)
      end
    end

    context 'when store does not exists' do
      before { get '/stores/XXXXXXX' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /stores' do
    before do
      post '/stores', params: { store: store_params }
    end

    context 'when params are valid' do
      let(:store_params) do
        { name: 'Cable', address: "Moon" }
      end

      it 'returns stauts code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the created store' do
        expect(json_body[:store]).to be_present
        expect(json_body[:store][:name]).to eq(store_params[:name])
      end
    end

    context 'when params are invalid' do
      let(:store_params) do
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

  describe 'PUT /stores/:id' do
    let(:store_id) { 1 }

    before do
      put "/stores/#{store_id}", params: { store: store_params }
    end

    context 'when params are valid' do
      let(:store_params) do
        { address: "Sun" }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns updated store' do
        expect(json_body[:store][:address]).to eq(store_params[:address])
      end
    end

    context 'when params are invalid' do
      let(:store_params) do
        { name: nil }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors message' do
        expect(json_body[:errors]).to be_present
        expect(json_body[:errors][:name]).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /stores/:id' do
    let(:store_id) { 1 }
    before { delete "/stores/#{store_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
