# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < Api::BaseController
      def index
        outcome = ListCategories.run index_params

        return render_resource_errors outcome unless outcome.valid?

        @categories = outcome.result
      end

      private

      def index_params
        params.permit :page, :per_page
      end
    end
  end
end
