# frozen_string_literal: true

json.products products do |product|
  json.extract! product, :id, :title, :status
  json.poster product.poster.url(:thumb)
end
