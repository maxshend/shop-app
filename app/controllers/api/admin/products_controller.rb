# frozen_string_literal: true

module Api
  module Admin
    class ProductsController < Api::BaseController
      def index
        outcome = ListProducts.run index_params

        return render_resource_errors outcome unless outcome.valid?

        @products = outcome.result
      end

      private

      def index_params
        params.permit :page, :per_page, :title, :status, :active, :min_price, :max_price, categories: []
      end
    end
  end
end
