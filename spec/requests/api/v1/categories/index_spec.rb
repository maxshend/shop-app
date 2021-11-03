# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/categories', type: :request do
  let!(:categories) { create_list :category, 3 }

  describe 'without params' do
    before do
      get '/api/v1/categories'
    end

    it 'has ok status' do
      expect(response).to have_http_status :ok
    end

    it 'returns correct categories number' do
      expect(json['categories'].size).to eq categories.size
    end

    it 'returns available categories' do
      expect(json).to eq 'categories' => categories.reverse.map { |c| category_attrs(c) }
    end
  end

  describe 'with params' do
    before do
      get '/api/v1/categories', params: params
    end

    context 'when params are valid' do
      let(:params) { { page: 1, per_page: 2 } }

      it 'has ok status' do
        expect(response).to have_http_status :ok
      end

      it 'returns correct categories number' do
        expect(json['categories'].size).to eq categories.size - 1
      end

      it 'returns paged categories' do
        expect(json).to eq 'categories' => categories.last(2).reverse.map { |c| category_attrs(c) }
      end
    end

    context 'when params are ivalid' do
      let(:params) { { page: 'invalid' } }

      it 'has unpocessable status' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns errors' do
        expect(json).to eq 'errors' => [{ 'key' => 'page', 'messages' => ['Page is not a valid integer'] }]
      end
    end
  end
end
