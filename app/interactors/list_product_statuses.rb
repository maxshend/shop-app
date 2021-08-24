# frozen_string_literal: true

class ListProductStatuses < ActiveInteraction::Base
  def execute
    statuses = Product.statuses.map do |k, _|
      { name: Product.human_enum_name(name: :status, value: k), key: k }
    end

    statuses.unshift name: Product.human_enum_name(name: :status, value: :all), key: ''

    statuses
  end
end
