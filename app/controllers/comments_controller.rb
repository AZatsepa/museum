# frozen_string_literal: true

class CommentsController < ApplicationController
  load_and_authorize_resource except: %i[create]
  before_action :set_comment_post
  after_action :change_comments, only: %i[create destroy]
  after_action :change_comments_by_form, only: %i[update]

  respond_to :json

  def create
    @comment = current_user.comments.build(comment_params.merge(post: @post))
    authorize! :create, @comment
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages.to_json, status: :unprocessable_entity
    end
  end

  def update
    @comment_form = CommentForm.new(update_comment_params.merge(comment: @comment))
    if @comment_form.update
      render json: @comment.reload, serializer: CommentSerializer
    else
      render json: @comment_form.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    respond_with(@comment.destroy, location: post_comments_path(@post))
  end

  private

  def comment_params
    params.require(:comment).permit(:text, images: [])
  end

  def update_comment_params
    params.require(:comment).permit(:text, images: [], destroy_images: [])
  end

  def set_comment_post
    @post = params[:action].eql?('create') ? Post.find(params[:post_id]) : @comment.post
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
      "comments_for_post_#{params[:post_id]}", comment: CommentSerializer.new(@comment_form.comment.reload),
                                               action: params[:action],
                                               comment_id: @comment_form.comment.id
    )
  end
end
