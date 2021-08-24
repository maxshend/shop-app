# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v1/locales', type: :request do
  let!(:locales) { ListLocales.run! }

  before do
    get '/api/v1/locales'
  end

  it 'has ok status' do
    expect(response).to have_http_status :ok
  end

  it 'returns available locales' do
    expect(json).to eq 'locales' => locales
  end
end
