# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/products', type: :request do
  describe 'without params' do
    let!(:products) { create_list :product, 2, :active }

    before do
      create_list :product, 2, :disabled

      get '/api/v1/products'
    end

    it 'has ok status' do
      expect(response).to have_http_status :ok
    end

    it 'returns correct products number' do
      expect(json['products'].size).to eq products.size
    end

    it 'returns active products list' do
      expect(json).to eq(
        'products' => products.reverse.map { |p| product_attrs(p) }
      )
    end
  end

  describe 'with params' do
    let!(:product) { create :product, :active }
    let!(:product_category) { create :product_category, product: product }

    before do
      create_list :product, 2, :active

      get '/api/v1/products', params: {
        page: 1, per_page: 1, title: product.title, status: product.status,
        min_price: product.price_cents, max_price: product.price_cents + 1,
        categories: [product_category.category_id]
      }
    end

    it 'has ok status' do
      expect(response).to have_http_status :ok
    end

    it 'returns filtered products list' do
      expect(json).to eq(
        'products' => [product_attrs(product)]
      )
    end
  end

  describe 'with invalid params' do
    before do
      get '/api/v1/products', params: { min_price: 'invalid' }
    end

    it 'has unprocessable status' do
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns errors' do
      expect(json).to eq(
        'errors' => [
          { 'key' => 'min_price', 'messages' => ['Min price is not a valid integer'] }
        ]
      )
    end
  end
end
