# frozen_string_literal: true

class UpdateAdminUser < ActiveInteraction::Base
  object :user, class: AdminUser
  string :email, :name

  validates :email, :name, presence: true

  def execute
    errors.merge! user.errors unless user.update inputs.except(:user)

    user
  end
end
