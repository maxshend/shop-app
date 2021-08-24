# frozen_string_literal: true

module Api
  module V1
    class LocalesController < Api::BaseController
      def index
        @locales = ListLocales.run!
      end
    end
  end
end
