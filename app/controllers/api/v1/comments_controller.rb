module Api
  module V1
    class CommentsController < Api::V1::BaseController
      def index
        respond_with Post.find(params[:post_id]).comments
      end

      def show
        respond_with Comment.find(params[:id])
      end
    end
  end
end
