# frozen_string_literal: true

module Api
  module Admin
    class AdminUsersController < Api::BaseController
      def index
        outcome = ListAdminUsers.run index_params

        return render_resource_errors outcome unless outcome.valid?

        @admin_users = outcome.result
      end

      private

      def index_params
        params.permit :page, :per_page
      end
    end
  end
end
