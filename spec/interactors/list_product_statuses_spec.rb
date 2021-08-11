# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListProductStatuses do
  let!(:statuses) { described_class.run! }

  it 'returns possible product statuses' do
    expect(statuses).to eq [
      ['In Stock', 0],
      ['Out Of Stock', 1],
      ['Coming Soon', 2]
    ]
  end
end
