# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  subject { build :product_category }

  describe 'associations' do
    it { should belong_to :product }
    it { should belong_to :category }
  end
end
