# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /api/admin/admin_users/:id', type: :request do
  context 'when user found' do
    let!(:admin_user) { create :admin_user }

    context 'when user can be destroyed' do
      before :each, with_before: true do
        delete "/api/admin/admin_users/#{admin_user.id}"
      end

      it 'has ok status', :with_before do
        expect(response).to have_http_status :ok
      end

      it 'returns success', :with_before do
        expect(json).to eq 'success' => true
      end

      it 'destroys user record' do
        expect do
          delete "/api/admin/admin_users/#{admin_user.id}"
        end.to change(AdminUser, :count).from(1).to 0
      end
    end

    context 'when user cannot be destroyed' do
      let(:error_message) { 'Cannot be destroyed' }
      let(:destroy_user) { instance_double(AdminUser) }

      before do
        allow(AdminUser).to receive(:find_by).and_return destroy_user
        allow(destroy_user).to receive(:destroy).and_return false
        fake_error destroy_user, :base, error_message

        delete "/api/admin/admin_users/#{admin_user.id}"
      end

      it 'has unprocessable status' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns errors' do
        expect(json).to eq 'errors' => [{ 'key' => 'base', 'messages' => [error_message] }]
      end
    end
  end

  context 'when user not found' do
    before do
      delete '/api/admin/admin_users/0'
    end

    it 'has unprocessable status' do
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns errors' do
      expect(json).to eq 'errors' => [{ 'key' => 'base', 'messages' => ['Admin user not found'] }]
    end
  end
end
