# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListLocales, type: :interactor do
  let!(:locales) { described_class.run! }

  it 'returns available locales' do
    expect(locales).to eq available_locales
  end
end
