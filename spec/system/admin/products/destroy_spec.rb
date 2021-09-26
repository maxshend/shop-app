# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Destroy a product', type: :system do
  let!(:products) { create_list :product, 5 }

  before do
    visit admin_products_path
  end

  describe 'without errors' do
    before do
      find('.productRow:first-child .deleteProductBtn').click
    end

    it 'removes a row from products table' do
      expect(page).to have_css '.productRow', count: products.size - 1
    end
  end

  describe 'with errors' do
    before do
      failed_destroy Product

      find('.productRow:first-child .deleteProductBtn').click
    end

    it 'does not remove a row from products table' do
      expect(page).to have_css '.productRow', count: products.size
    end
  end
end
