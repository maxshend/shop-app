# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List products', type: :system do
  let!(:active_products) do
    products = Product.statuses.keys.map do |status|
      category = create :category
      products = create_list :product, 3, :active, status: status
      products.each { |p| create :product_category, product: p, category: category }
    end

    products.flatten
  end

  before do
    create_list :product, 2, :disabled

    visit products_path
  end

  describe 'without filters' do
    it 'shows valid number of products' do
      expect(page).to have_css('.product-item', count: active_products.size)
    end

    it 'shows a list of active products' do
      active_products.each do |product|
        expect(page).to have_css('.product-item', text: product.title)
      end
    end
  end

  describe 'with filters' do
    let(:product_status) { Product.statuses.keys.first }
    let!(:categories) { Category.all }
    let!(:product) { active_products.first }
    let!(:filtered_products) do
      ListProducts.run!(
        status: product_status, categories: categories.map(&:id),
        title: product.title, min_price: 0, max_price: product.price_cents
      )
    end

    before do
      select Product.human_enum_name(name: :status, value: product_status), from: 'status_select'
      categories.map(&:name).each { |name| check name }
      fill_in 'searchInput', with: product.title
      fill_in 'minPriceInput', with: 0
      fill_in 'maxPriceInput', with: product.price.to_f
    end

    it 'shows valid number of products' do
      expect(page).to have_css('.product-item', count: filtered_products.size)
    end

    it 'shows a list of filtered products' do
      filtered_products.each do |product|
        expect(page).to have_css('.product-item', text: product.title)
      end
    end
  end
end
