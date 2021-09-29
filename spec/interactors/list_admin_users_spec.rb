# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListAdminUsers, type: :interactor do
  let!(:available_users) { create_list :admin_user, 5 }

  describe 'with default pagination' do
    let!(:users) { described_class.run! }

    it 'returns admin users' do
      expect(users).to eq available_users.reverse
    end
  end

  describe 'with custom pagination' do
    let!(:users) { described_class.run! page: 2, per_page: 1 }

    it 'returns admin users' do
      expect(users).to eq [available_users.reverse.second]
    end
  end

  describe 'with invalid params' do
    let!(:users) { described_class.run page: 'invalid' }

    it 'returns errors' do
      expect(users.errors.details).to eq page: [{ error: :invalid_type, type: 'integer' }]
    end
  end
end
