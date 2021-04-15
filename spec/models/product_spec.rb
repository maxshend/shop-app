# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build :product }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }

    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values %i[in_stock out_of_stock coming_soon] }

    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to 0 }

    %i[price_cents old_price_cents].each do |price|
      it { should validate_presence_of price }
      it { should validate_numericality_of(price).is_greater_than_or_equal_to 0 }
    end
  end
end
