# frozen_string_literal: true

class ListProductStatuses < ActiveInteraction::Base
  def execute
    Product.statuses.map do |k, _|
      { name: Product.human_enum_name(:status, k), key: k }
    end
  end
end
