# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListProductStatuses do
  let!(:statuses) { described_class.run! }

  it 'returns possible product statuses' do
    expect(statuses).to eq [
      { name: 'In Stock', key: 'in_stock' },
      { name: 'Out Of Stock', key: 'out_of_stock' },
      { name: 'Coming Soon', key: 'coming_soon' }
    ]
  end
end
