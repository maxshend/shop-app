# frozen_string_literal: true

module Helpers
  module Request
    def json
      JSON.parse response.body
    end

    def product_attrs(p)
      {
        'id' => p.id,
        'title' => p.title,
        'status' => Product.human_enum_name(name: :status, value: p.status),
        'poster' => p.poster.url(:thumb),
        'price' => p.price.format,
        'old_price' => p.old_price.format
      }
    end

    def admin_product_attrs(p)
      {
        'id' => p.id,
        'title' => p.title,
        'quantity' => p.quantity,
        'active' => p.active,
        'status' => Product.human_enum_name(name: :status, value: p.status),
        'price' => p.price.format,
        'created_at' => I18n.l(p.created_at, format: :with_time)
      }
    end

    def category_attrs(c)
      {
        'id' => c.id,
        'name' => c.name
      }
    end
  end
end
