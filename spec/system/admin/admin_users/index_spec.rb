# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List admin users', type: :system do
  let!(:admin_users) { create_list :admin_user, 5 }

  before do
    visit '/admin/admin_users'
  end

  it 'displays header' do
    expect(page).to have_css 'header'
  end

  it 'displays admin users table' do
    expect(page).to have_css '#adminUsersTable'
  end

  it 'shows valid number of admin users' do
    expect(page).to have_css('.adminUserRow', count: admin_users.size)
  end

  it 'shows existing admin users' do
    admin_users.each do |u|
      expect(page).to have_css('.adminUserRow', text: u.email)
    end
  end
end
