# frozen_string_literal: true

module Helpers
  module Interactor
    def product_statuses_enum
      [
        { name: 'All', key: '' },
        { name: 'In Stock', key: 'in_stock' },
        { name: 'Out Of Stock', key: 'out_of_stock' },
        { name: 'Coming Soon', key: 'coming_soon' }
      ]
    end
  end
end
