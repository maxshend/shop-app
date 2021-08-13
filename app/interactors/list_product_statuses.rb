# frozen_string_literal: true

class ListProductStatuses < ActiveInteraction::Base
  string :lang, default: nil

  def execute
    statuses = Product.statuses.map do |k, _|
      { name: Product.human_enum_name(name: :status, value: k, lang: lang), key: k }
    end

    statuses.unshift name: Product.human_enum_name(name: :status, value: :all, lang: lang), key: ''

    statuses
  end
end
