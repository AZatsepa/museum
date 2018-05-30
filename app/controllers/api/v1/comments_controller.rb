module Api
  module V1
    class CommentsController < Api::V1::BaseController
      def index
        respond_with Post.find(params[:post_id]).comments
      end

      def show
        respond_with Comment.find(params[:id])
      end

      def create
        @post = Post.find(params[:post_id])
        respond_with @post.comments.create(comment_params.merge(user: current_resource_owner)),
                     location: false
      end

      private

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
