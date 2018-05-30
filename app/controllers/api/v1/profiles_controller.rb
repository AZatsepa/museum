module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      def me
        respond_with current_resource_owner
      end

      def other_users
        respond_with User.where.not(id: current_resource_owner.id)
      end
    end
  end
end
