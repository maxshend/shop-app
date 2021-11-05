# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /api/admin/admin_users/:id', type: :request do
  context 'when user found' do
    let!(:admin_user) { create :admin_user }

    describe 'with valid params' do
      let(:params) { { email: 'foo@mail.com', name: 'bar' } }

      before :each, with_before: true do
        put "/api/admin/admin_users/#{admin_user.id}", params: { admin_user: params }
      end

      it 'hash ok status', :with_before do
        expect(response).to have_http_status :ok
      end

      it 'returns success', :with_before do
        expect(json).to eq 'success' => true
      end

      it 'updates admin user record' do
        expect do
          put "/api/admin/admin_users/#{admin_user.id}", params: { admin_user: params }
        end.to change {
          u = AdminUser.find admin_user.id
          [u.email, u.name]
        }.from([admin_user.email, admin_user.name]).to [params[:email], params[:name]]
      end
    end

    describe 'with invalid params' do
      let(:params) { { email: '', name: '' } }

      before :each, with_before: true do
        put "/api/admin/admin_users/#{admin_user.id}", params: { admin_user: params }
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

      it 'does not update admin user record' do
        expect do
          put "/api/admin/admin_users/#{admin_user.id}", params: { admin_user: params }
        end.not_to(
          change do
            u = AdminUser.find admin_user.id
            [u.email, u.name]
          end
        )
      end
    end
  end

  context 'when user not found' do
    before do
      put '/api/admin/admin_users/0'
    end

    it 'has unprocessable status' do
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns errors' do
      expect(json).to eq 'errors' => [{ 'key' => 'base', 'messages' => ['Admin user not found'] }]
    end
  end
end
