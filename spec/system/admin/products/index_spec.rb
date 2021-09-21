# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List products', type: :system do
  let!(:products) { create_list :product, 5 }

  before do
    visit admin_products_path
  end

  it 'displays header' do
    expect(page).to have_css 'header'
  end

  it 'displays products table' do
    expect(page).to have_css '#productsTable'
  end

  it 'shows valid number of products' do
    expect(page).to have_css('.productRow', count: products.size)
  end

  it 'shows existing products' do
    products.each do |p|
      expect(page).to have_css('.productRow', text: p.title)
    end
  end
end
