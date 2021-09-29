# frozen_string_literal: true

class AdminUser < ApplicationRecord
  validates :name, presence: true, length: { maximum: 200 }
  validates :email, presence: true, length: { maximum: 320 }, uniqueness: { case_sensitive: false }
end
