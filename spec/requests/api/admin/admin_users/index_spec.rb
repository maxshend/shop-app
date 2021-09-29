# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/admin/admin_users', type: :request do
  let!(:users) { create_list :admin_user, 5 }

  describe 'without params' do
    before do
      get '/api/admin/admin_users'
    end

    it 'has ok status' do
      expect(response).to have_http_status :ok
    end

    it 'returns admin users list' do
      expect(json).to eq(
        'admin_users' => users.reverse.map { |u| admin_user_attrs(u) }
      )
    end
  end

  describe 'with params' do
    before do
      get '/api/admin/admin_users', params: { page: 1, per_page: 1 }
    end

    it 'has ok status' do
      expect(response).to have_http_status :ok
    end

    it 'returns paginated admin users list' do
      expect(json).to eq(
        'admin_users' => [admin_user_attrs(users.last)]
      )
    end
  end

  describe 'with invalid params' do
    before do
      get '/api/admin/admin_users', params: { page: 'invalid' }
    end

    it 'has unprocessable status' do
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns errors' do
      expect(json).to eq(
        'errors' => [
          { 'key' => 'page', 'messages' => ['Page is not a valid integer'] }
        ]
      )
    end
  end
end
