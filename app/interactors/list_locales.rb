# frozen_string_literal: true

class ListLocales < ActiveInteraction::Base
  def execute
    I18n.available_locales.map(&:to_s)
  end
end
