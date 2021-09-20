# frozen_string_literal: true

json.products @products do |p|
  json.partial! 'product', product: p
end
