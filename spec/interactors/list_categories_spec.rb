# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListCategories, type: :interactor do
  let!(:available_categories) { create_list :category, 3 }

  describe 'without params' do
    let!(:categories) { described_class.run! }

    it 'returns available categories' do
      expect(categories).to eq available_categories.reverse
    end
  end

  describe 'with params' do
    context 'when params are valid' do
      let!(:categories) { described_class.run! page: 1, per_page: 2 }

      it 'returns paged categories' do
        expect(categories).to eq available_categories.last(2).reverse
      end
    end

    context 'when params are invalid' do
      let!(:categories) { described_class.run page: 'foo' }

      it 'returns errors' do
        expect(categories.errors.details).to eq page: [{ error: :invalid_type, type: 'integer' }]
      end
    end
  end
end
