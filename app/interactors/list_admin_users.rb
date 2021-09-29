# frozen_string_literal: true

class ListAdminUsers < ActiveInteraction::Base
  integer :page, default: nil
  integer :per_page, default: nil

  def execute
    AdminUser.order(created_at: :desc).page(page).per per_page
  end
end
