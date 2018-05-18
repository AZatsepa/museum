class PostsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show
    @comment = @post.comments.build
    @comment.attachments.build
  end
end
