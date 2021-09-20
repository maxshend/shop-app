# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/admin/products', type: :request do
  describe 'without params' do
    let!(:products) { create_list :product, 5 }

    before do
      get '/api/admin/products'
    end

    it 'has ok status' do
      expect(response).to have_http_status :ok
    end

    it 'returns products list' do
      expect(json).to eq(
        'products' => products.reverse.map { |p| admin_product_attrs(p) }
      )
    end
  end

  describe 'with params' do
    let!(:product) { create :product, :active }
    let!(:product_category) { create :product_category, product: product }

    before do
      create_list :product, 2

      get '/api/admin/products', params: {
        page: 1, per_page: 1, title: product.title, status: product.status,
        min_price: product.price_cents, max_price: product.price_cents + 1,
        categories: [product_category.category_id], active: true
      }
    end

    it 'has ok status' do
      expect(response).to have_http_status :ok
    end

    it 'returns filtered products list' do
      expect(json).to eq(
        'products' => [admin_product_attrs(product)]
      )
    end
  end
end
