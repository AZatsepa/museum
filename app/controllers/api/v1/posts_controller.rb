module Api
  module V1
    class PostsController < Api::V1::BaseController
      def index
        respond_with Post.all
      end
    end
  end
end
