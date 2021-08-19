# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/products', type: :request do
  describe 'without params' do
    let!(:products) { create_list :product, 2 }

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
    let!(:product) { create :product }

    before do
      create_list :product, 2

      get '/api/v1/products', params: {
        page: 1, per_page: 1, title: product.title, status: product.status,
        min_price: product.price_cents, max_price: product.price_cents + 1
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
end
