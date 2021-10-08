# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Destroy an admin user', type: :system do
  let!(:admin_users) { create_list :admin_user, 5 }

  before do
    visit '/admin/admin_users'
  end

  describe 'without errors' do
    before do
      find('.adminUserRow:first-child .deleteAdminUserBtn').click
    end

    it 'removes a row from admin users table' do
      expect(page).to have_css '.adminUserRow', count: admin_users.size - 1
    end
  end

  describe 'with errors' do
    before do
      failed_destroy AdminUser

      find('.adminUserRow:first-child .deleteAdminUserBtn').click
    end

    it 'does not remove a row from admin users table' do
      expect(page).to have_css '.adminUserRow', count: admin_users.size
    end
  end
end
