# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateAdminUser, type: :interactor do
  let(:admin_user) { create :admin_user }
  let(:params) { build :admin_user }

  context 'when user found' do
    describe 'with valid params' do
      let(:new_user) { described_class.run! user: admin_user, email: params.email, name: params.name }

      it 'updates admin user record' do
        expect { new_user }.to change {
          u = AdminUser.find admin_user.id
          [u.email, u.name]
        }.from([admin_user.email, admin_user.name]).to [params.email, params.name]
      end

      it 'returns updated admin user object' do
        expect(new_user).to eq AdminUser.find(admin_user.id)
      end
    end

    describe 'with invalid params' do
      let(:new_user) { described_class.run user: admin_user, email: '', name: '' }

      it 'does not update user reocord' do
        expect { new_user }.not_to(
          change do
            u = AdminUser.find admin_user.id
            [u.email, u.name]
          end
        )
      end

      it 'returns errors' do
        expect(new_user.errors.details).to eq email: [{ error: :blank }], name: [{ error: :blank }]
      end
    end
  end

  context 'when user not found' do
    let(:new_user) { described_class.run user: nil, email: params.email, name: params.name }

    it 'returns errors' do
      expect(new_user.errors.details).to eq user: [{ error: :missing }]
    end
  end
end
