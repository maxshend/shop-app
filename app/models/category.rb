# frozen_string_literal: true

class Category < ApplicationRecord
  extend Mobility
  translates :name

  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
