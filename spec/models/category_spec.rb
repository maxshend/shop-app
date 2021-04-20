# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build :category }

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_most 50 }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    it { should have_many :products }
    it { should have_many(:product_categories).dependent :destroy }
  end
end
