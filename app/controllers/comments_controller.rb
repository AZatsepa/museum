class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment_post
  after_action :change_comments

  respond_to :json

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge!(user: current_user))
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @comment.update(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    respond_with(@comment.destroy)
  end

  private

  def comment_params
    params.require(:comment).permit(:text, attachments_attributes: %i[file _destroy id])
  end

  def set_comment_post
    @post = if params[:action].eql?('create')
              Post.find(params[:post_id])
            else
              @comment.post
            end
  end

  def change_comments
    return if @comment.errors.any?
    ActionCable.server.broadcast(
      "comments_for_post_#{params[:post_id]}",
      comment: CommentSerializer.new(@comment),
      action: params[:action],
      comment_id: params[:id]
    )
  end
end
