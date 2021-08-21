# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListProducts, type: :interactor do
  let!(:active_products) { create_list :product, 3, :active }

  before do
    create_list :product, 2, :disabled
  end

  describe 'with default pagination' do
    let!(:products) { described_class.run! }

    it 'returns active products' do
      expect(products).to eq active_products.reverse
    end
  end

  describe 'with custom pagination' do
    let!(:products) { described_class.run! page: 3, per_page: 1 }

    it 'returns active products last page' do
      expect(products).to eq [active_products.first]
    end
  end

  describe 'with price filtering' do
    let(:price) { 1_000 }

    context 'when min price passed' do
      before do
        active_products.each { |p| p.update!(price: 0) && p.reload }
      end

      let!(:found_product) { create :product, :active, price: price }
      let!(:products) { described_class.run! min_price: price }

      it 'returns filtered results' do
        expect(products).to eq [found_product]
      end
    end

    context 'when max price passed' do
      before do
        active_products.each { |p| p.update!(price: price + 1) && p.reload }
      end

      let!(:found_product) { create :product, :active, price: price }
      let!(:products) { described_class.run! max_price: price * 100 }

      it 'returns filtered results' do
        expect(products).to eq [found_product]
      end
    end

    context 'when price range passed' do
      before do
        active_products.each { |p| p.update!(price: 0) && p.reload }
      end

      let!(:found_product) { create :product, :active, price: price }
      let!(:products) { described_class.run! min_price: (price - 1) * 100, max_price: (price + 1) * 100 }

      it 'returns filtered results' do
        expect(products).to eq [found_product]
      end
    end
  end

  describe 'with additional filter params' do
    context 'when params are valid' do
      before do
        active_products.first.update! title: found_product.title
        create :product_category, product: active_products.last, category: product_category.category
      end

      let!(:found_product) { create :product, :active, title: 'Found!' }
      let!(:product_category) { create :product_category, product: found_product }
      let!(:products) { described_class.run! title: 'ound!', categories: [product_category.category_id] }

      it 'returns filtered results' do
        expect(products).to eq [found_product]
      end
    end

    context 'when params are invalid' do
      let!(:products) { described_class.run categories: ['invalid'] }

      it 'returns errors' do
        expect(products.errors.details).to eq categories: [{ error: :invalid_type, type: 'array' }]
      end
    end
  end
end
