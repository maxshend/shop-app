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
        'status' => Product.human_enum_name(:status, p.status),
        'poster' => p.poster.url(:thumb),
        'price' => p.price.format,
        'old_price' => p.old_price.format
      }
    end
  end
end
