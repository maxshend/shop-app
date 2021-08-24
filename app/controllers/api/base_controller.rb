# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include Errors::ErrorHandler

    around_action :switch_locale

    private

    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale

      I18n.with_locale locale, &action
    end
  end
end
