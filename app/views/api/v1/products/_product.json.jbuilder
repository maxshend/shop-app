# frozen_string_literal: true

json.extract! product, :id, :title
json.status Product.human_enum_name(name: :status, value: product.status)
json.price product.price.format
json.old_price product.old_price.to_f.zero? ? nil : product.old_price.format
json.poster product.poster.url(:thumb)
