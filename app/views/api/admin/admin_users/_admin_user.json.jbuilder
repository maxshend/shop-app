# frozen_string_literal: true

json.extract! admin_user, :id, :name, :email
json.created_at I18n.l(admin_user.created_at, format: :with_time)
