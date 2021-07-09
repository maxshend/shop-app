# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = ListProducts.run! index_params
  end

  private

  def index_params
    params.permit :page, :per_page
  end
end
