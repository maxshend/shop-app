# frozen_string_literal: true

json.admin_users @admin_users do |u|
  json.partial! 'admin_user', admin_user: u
end
