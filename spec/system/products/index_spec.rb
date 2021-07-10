# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List products', type: :system do
  let!(:active_products) { create_list :product, 3, :active }

  before do
    create_list :product, 2, :disabled

    visit products_path
  end

  it 'shows valid number of products' do
    expect(page).to have_css('li', count: active_products.size)
  end

  it 'shows a list of active products' do
    active_products.each do |product|
      expect(page).to have_css('li', text: "#{product.title} #{product.id}")
    end
  end
end
