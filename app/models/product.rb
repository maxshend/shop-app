# frozen_string_literal: true

class Product < ApplicationRecord
  mount_uploader :poster, PosterUploader

  monetize :price_cents
  monetize :old_price_cents

  enum status: { in_stock: 0, out_of_stock: 1, coming_soon: 2 }

  validates :title, :description, :status, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price_cents, :old_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
