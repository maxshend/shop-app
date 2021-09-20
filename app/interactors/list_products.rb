# frozen_string_literal: true

class ListProducts < ActiveInteraction::Base
  integer :page, default: nil
  integer :per_page, default: nil
  string :title, default: nil
  string :status, default: nil
  integer :min_price, default: nil
  integer :max_price, default: nil
  boolean :active, default: nil
  array :categories, default: nil do
    integer
  end

  def execute
    products = Product.active(active).with_categories(categories).with_title(title).with_status(status)
                      .with_price_cents(min_price, max_price).order created_at: :desc

    products.page(page).per per_page
  end
end
