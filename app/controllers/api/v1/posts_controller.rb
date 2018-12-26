# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::V1::BaseController
      load_and_authorize_resource

      def index
        respond_with Post.includes(:comments, images_attachments: :blob).order(:id).all
      end

      def show
        respond_with Post.with_attached_images.includes(:comments).find(params[:id])
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
