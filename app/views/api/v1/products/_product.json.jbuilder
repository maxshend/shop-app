# frozen_string_literal: true

json.extract! product, :id, :title, :status
json.poster product.poster.url(:thumb)
