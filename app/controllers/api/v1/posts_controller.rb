# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::V1::BaseController
      def index
        respond_with Post.all
      end

      def show
        respond_with Post.find(params[:id])
      end

      def create
        respond_with current_resource_owner.posts.create(post_params)
      end

      private

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end
