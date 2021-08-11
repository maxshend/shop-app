# frozen_string_literal: true

class ListProductStatuses < ActiveInteraction::Base
  def execute
    Product.statuses.map do |k, v|
      [Product.human_enum_name(:status, k), v]
    end
  end
end
