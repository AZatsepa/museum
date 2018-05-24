class CommentsController < ApplicationController
  load_and_authorize_resource
  after_action :change_comments, only: %i[create update destroy]

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
    @post = @comment.post
    @comment.update(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @post = @comment.post
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text, attachments_attributes: %i[file _destroy id])
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
