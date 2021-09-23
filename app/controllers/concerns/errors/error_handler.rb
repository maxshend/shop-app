# frozen_string_literal: true

module Errors
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from(StandardError) { |error| respond 500, error }
    end

    private

    def render_errors(errors: [], status: :unprocessable_entity)
      render json: { errors: errors }, status: status
    end

    def render_resource_errors(resource, status: :unprocessable_entity, forced_key: nil)
      result = resource.errors.attribute_names.map do |attr|
        { key: forced_key || attr, messages: resource.errors.full_messages_for(attr) }
      end

      render_errors errors: result, status: status
    end

    def respond(status, error, log: true)
      if log
        Rails.logger.info { "#{error.class}: #{error.message}" }
        Rails.logger.info { "\t#{error.backtrace.join("\n\t")}" }
      end

      render json: { errors: [error.to_s] }, status: status
    end

    def render_resource_not_found(resource_class = nil)
      resource_name = resource_class&.model_name&.human || I18n.t('resource.name')
      render_errors errors: [{ key: :base, messages: [I18n.t('errors.not_found', resource: resource_name)] }]
    end
  end
end
