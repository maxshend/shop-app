# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListProductStatuses, type: :interactor do
  let!(:statuses) { described_class.run! }

  it 'returns possible product statuses' do
    expect(statuses).to eq product_statuses_enum
  end
end
