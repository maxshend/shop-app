# frozen_string_literal: true

class Product < ApplicationRecord
  mount_uploader :poster, PosterUploader

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  scope :active, -> { where active: true }
  scope :with_status, ->(status) { status.nil? ? all : where(status: status) }
  scope :with_categories, lambda { |categories|
    categories.nil? ? all : joins(:categories).where(categories: { id: categories })
  }
  scope :with_title, lambda { |title|
    title.nil? ? all : where('LOWER(title) LIKE ?', "%#{title.downcase}%")
  }
  scope :with_price_cents, lambda { |min_price, max_price|
    filtered = all

    return filtered if min_price.nil? && max_price.nil?

    filtered = filtered.where('price_cents >= ?', min_price) if min_price
    filtered = filtered.where('price_cents <= ?', max_price) if max_price

    filtered
  }

  monetize :price_cents
  monetize :old_price_cents

  enum status: { in_stock: 0, out_of_stock: 1, coming_soon: 2 }

  validates :title, :description, :status, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price_cents, :old_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
