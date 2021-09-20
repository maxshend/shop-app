# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List products', type: :system do
  before do
    visit admin_products_path
  end

  it 'displays header' do
    expect(page).to have_css 'header'
  end

  it 'displays products table' do
    expect(page).to have_css '#productsTable'
  end
end
