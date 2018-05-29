module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :doorkeeper_authorize!

      respond_to :json

      def me
        respond_with current_resource_owner
      end

      def other_users
        respond_with User.where.not(id: current_resource_owner.id)
      end

      protected

      def current_resource_owner
        @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
