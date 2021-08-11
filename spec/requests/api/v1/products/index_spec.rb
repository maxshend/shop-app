# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/products', type: :request do
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
