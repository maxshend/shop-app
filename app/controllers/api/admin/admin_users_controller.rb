# frozen_string_literal: true

module Api
  module Admin
    class AdminUsersController < Api::BaseController
      before_action :set_admin_user, only: %i[destroy]

      def index
        outcome = ListAdminUsers.run index_params

        return render_resource_errors outcome unless outcome.valid?

        @admin_users = outcome.result
      end

      def destroy
        render_resource_errors @admin_user unless @admin_user.destroy
      end

      private

      def index_params
        params.permit :page, :per_page
      end

      def set_admin_user
        @admin_user = AdminUser.find_by id: params[:id]

        render_resource_not_found(AdminUser) unless @admin_user
      end
    end
  end
end
