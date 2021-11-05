# frozen_string_literal: true

module Api
  module Admin
    class AdminUsersController < Api::BaseController
      before_action :set_admin_user, only: %i[update destroy]

      def index
        outcome = ListAdminUsers.run index_params

        return render_resource_errors outcome unless outcome.valid?

        @admin_users = outcome.result
      end

      def create
        outcome = CreateAdminUser.run create_params

        render_resource_errors outcome unless outcome.valid?
      end

      def update
        outcome = UpdateAdminUser.run create_params.merge(user: @admin_user)

        render_resource_errors outcome unless outcome.valid?
      end

      def destroy
        render_resource_errors @admin_user unless @admin_user.destroy
      end

      private

      def index_params
        params.permit :page, :per_page
      end

      def create_params
        params.require(:admin_user).permit :email, :name
      end

      def set_admin_user
        @admin_user = AdminUser.find_by id: params[:id]

        render_resource_not_found(AdminUser) unless @admin_user
      end
    end
  end
end
