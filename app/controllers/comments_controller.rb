class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment_post
  after_action :change_comments

  respond_to :json

  def create
    @comment_form = CommentForm.new(comment_params.merge(current_user: current_user, post: @post))
    @comment = @comment_form.comment
    if @comment_form.save
      render json: @comment
    else
      render json: @comment_form.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    @comment_form = CommentForm.new(comment_params.merge(comment: @comment, post: @post))
    @comment = @comment_form.comment
    if @comment_form.update
      render json: @comment
    else
      render json: @comment_form.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    respond_with(@comment.destroy, location: post_comments_path(@post))
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
      comment_id: @comment.id
    )
  end
end
