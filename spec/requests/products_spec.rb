# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /products', type: :request do
  before { get products_path }

  it 'returns success' do
    expect(response).to have_http_status(:ok)
  end

  it 'has HTML content status' do
    expect(response.content_type).to include 'text/html'
  end
end
