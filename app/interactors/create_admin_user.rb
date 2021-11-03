# frozen_string_literal: true

class CreateAdminUser < ActiveInteraction::Base
  string :email, :name

  validates :email, :name, presence: true

  def execute
    resource = AdminUser.new inputs

    errors.merge! resource.errors unless resource.save

    resource
  end
end
