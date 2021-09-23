# frozen_string_literal: true

module Api
  module Admin
    class ProductsController < Api::BaseController
      before_action :set_product, only: %i[destroy]

      def index
        outcome = ListProducts.run index_params

        return render_resource_errors outcome unless outcome.valid?

        @products = outcome.result
      end

      def destroy
        render_resource_errors @product unless @product.destroy
      end

      private

      def index_params
        params.permit :page, :per_page, :title, :status, :active, :min_price, :max_price, categories: []
      end

      def set_product
        @product = Product.find_by id: params[:id]

        render_resource_not_found(Product) unless @product
      end
    end
  end
end
