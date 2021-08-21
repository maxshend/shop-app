# frozen_string_literal: true

module Api
  module V1
    class ProductsController < Api::BaseController
      def index
        outcome = ListProducts.run index_params

        return render_resource_errors outcome unless outcome.valid?

        @products = outcome.result
      end

      def statuses
        outcome = ListProductStatuses.run statuses_params

        return render_resource_errors outcome unless outcome.valid?

        @statuses = outcome.result
      end

      private

      def index_params
        params.permit :page, :per_page, :title, :status, :min_price, :max_price, categories: []
      end

      def statuses_params
        params.permit :lang
      end
    end
  end
end
