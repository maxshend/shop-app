# frozen_string_literal: true

class ListProducts < ActiveInteraction::Base
  integer :page, default: nil
  integer :per_page, default: nil
  string :title, default: nil
  array :categories, default: nil do
    integer
  end

  def execute
    products = Product.active.order created_at: :desc
    products = products.where('LOWER(title) LIKE ?', "%#{title.downcase}%") if title.present?
    products = products.joins(:categories).where categories: { id: categories } if categories.present?

    products.page(page).per per_page
  end
end
