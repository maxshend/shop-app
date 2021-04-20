# frozen_string_literal: true

class Product < ApplicationRecord
  mount_uploader :poster, PosterUploader

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  monetize :price_cents
  monetize :old_price_cents

  enum status: { in_stock: 0, out_of_stock: 1, coming_soon: 2 }

  validates :title, :description, :status, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price_cents, :old_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
