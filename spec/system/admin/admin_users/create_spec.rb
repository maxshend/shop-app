# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create an admin user', type: :system do
  let!(:admin_users) { create_list :admin_user, 2 }
  let(:params) { build :admin_user }

  before do
    visit '/admin/admin_users/new'
  end

  describe 'without errors' do
    before do
      fill_in 'adminUserName', with: params.name
      fill_in 'adminUserEmail', with: params.email
      find('#adminUserForm button').click
    end

    it 'redirects to admin users index page' do
      expect(page).to have_css '.adminUserRow', count: admin_users.size + 1
    end

    it 'displays success message' do
      expect(page).to have_css '.infoMessage', text: 'Success'
    end
  end

  describe 'with errors' do
    before do
      find('#adminUserForm button').click
    end

    it 'shows email input errors' do
      expect(page).to have_css  '.inputError', text: "Email can't be blank"
    end

    it 'shows name input errors' do
      expect(page).to have_css '.inputError', text: "Name can't be blank"
    end
  end
end
