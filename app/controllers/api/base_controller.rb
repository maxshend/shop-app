# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include Errors::ErrorHandler
  end
end
