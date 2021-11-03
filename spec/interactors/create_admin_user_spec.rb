# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateAdminUser, type: :interactor do
  let(:admin_user) { build :admin_user }

  describe 'with valid params' do
    let(:new_user) { described_class.run! email: admin_user.email, name: admin_user.name }

    it 'creates new admin user record' do
      expect { new_user }.to change(AdminUser, :count).from(0).to 1
    end

    it 'returns newly created admin user object' do
      expect(new_user).to eq AdminUser.last
    end
  end

  describe 'with invalid params' do
    let(:new_user) { described_class.run email: '', name: '' }

    it 'does not create new admin user record' do
      expect { new_user }.not_to change(AdminUser, :count)
    end

    it 'returns errors' do
      expect(new_user.errors.details).to eq email: [{ error: :blank }], name: [{ error: :blank }]
    end
  end
end
