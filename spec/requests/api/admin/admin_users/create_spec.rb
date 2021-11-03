# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/admin/admin_users', type: :request do
  let(:admin_user) { build :admin_user }

  describe 'with valid params' do
    let(:params) { { email: admin_user.email, name: admin_user.name } }

    before :each, with_before: true do
      post '/api/admin/admin_users', params: { admin_user: params }
    end

    it 'hash ok status', :with_before do
      expect(response).to have_http_status :ok
    end

    it 'returns success', :with_before do
      expect(json).to eq 'success' => true
    end

    it 'creates new admin user record' do
      expect do
        post '/api/admin/admin_users', params: { admin_user: params }
      end.to change(AdminUser, :count).from(0).to 1
    end
  end

  describe 'with invalid params' do
    let(:params) { { email: '', name: '' } }

    before :each, with_before: true do
      post '/api/admin/admin_users', params: { admin_user: params }
    end

    it 'hash unprocessable status', :with_before do
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns errors', :with_before do
      expect(json).to eq(
        'errors' => [
          { 'key' => 'email', 'messages' => ["Email can't be blank"] },
          { 'key' => 'name', 'messages' => ["Name can't be blank"] }
        ]
      )
    end

    it 'does not create admin user record' do
      expect do
        post '/api/admin/admin_users', params: { admin_user: params }
      end.not_to change(AdminUser, :count)
    end
  end
end
