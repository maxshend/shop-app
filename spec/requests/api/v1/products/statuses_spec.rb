# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/products/statuses', type: :request do
  let!(:statuses) { ListProductStatuses.run! }

  before do
    get '/api/v1/products/statuses'
  end

  it 'has ok status' do
    expect(response).to have_http_status :ok
  end

  it 'returns possible product statuses' do
    expect(json).to eq 'statuses' => statuses
  end
end
