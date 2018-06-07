# frozen_string_literal: true

class CommentsController < ApplicationController
  load_and_authorize_resource except: %i[create]
  before_action :set_comment_post
  after_action :change_comments, only: %i[destroy]
  after_action :change_comments_by_form, only: %i[create update]

  respond_to :json

  def create
    @comment_form = CommentForm.new(comment_params.merge(user: current_user, post: @post))
    @comment = @comment_form.object
    authorize! :create, @comment
    if @comment_form.save
      render json: @comment
    else
      render json: @comment_form.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @comment_form = CommentForm.new(comment_params.merge(object: @comment, post: @post, user: current_user))
    @comment = @comment_form.object
    if @comment_form.update
      render json: @comment.reload
    else
      render json: @comment_form.errors.full_messages, status: :unprocessable_entity
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

  def change_comments_by_form
    return if @comment_form.errors.any?
    ActionCable.server.broadcast(
      "comments_for_post_#{params[:post_id]}", comment: CommentSerializer.new(@comment_form.object.reload),
                                               action: params[:action],
                                               comment_id: @comment_form.object.id
    )
  end
end
