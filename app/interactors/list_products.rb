# frozen_string_literal: true

class ListProducts < ActiveInteraction::Base
  integer :page, default: nil
  integer :per_page, default: nil
  string :title, default: nil
  string :status, default: nil
  array :categories, default: nil do
    integer
  end

  def execute
    products = Product.active.with_categories(categories).with_title(title).order created_at: :desc
    products = products.where(status: status) if status.present?

    products.page(page).per per_page
  end
end
