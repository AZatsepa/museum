module Api
  module V1
    class CommentsController < Api::V1::BaseController
      def index
        respond_with Post.find(params[:post_id]).comments
      end
    end
  end
end
