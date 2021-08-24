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
        @statuses = ListProductStatuses.run!
      end

      private

      def index_params
        params.permit :page, :per_page, :title, :status, :min_price, :max_price, categories: []
      end
    end
  end
end
