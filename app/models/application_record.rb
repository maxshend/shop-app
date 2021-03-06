# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_enum_name(name:, value:)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{name.to_s.pluralize}.#{value}")
  end
end
