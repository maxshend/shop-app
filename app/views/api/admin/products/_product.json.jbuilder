# frozen_string_literal: true

json.extract! product, :id, :title, :quantity, :active
json.status Product.human_enum_name(name: :status, value: product.status)
json.price product.price.format
json.created_at I18n.l(product.created_at)
