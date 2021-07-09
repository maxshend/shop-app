# frozen_string_literal: true

class ListProducts < ActiveInteraction::Base
  integer :page, default: nil
  integer :per_page, default: nil

  def execute
    Product.select(
      'id, title, poster, status, created_at, active'
    ).active.order(created_at: :desc).page(page).per(per_page)
  end
end
