# frozen_string_literal: true

module Admin
  class CommentsController < ApplicationController
    load_and_authorize_resource except: %i[create]
    before_action :set_comment_post, except: %i[index]
    respond_to :html
    def index
      @comments = Comment.includes(:user, :post).all
      authorize! :read, @comments
    end

    def show; end

    def edit; end

    def create
      @comment_form = CommentForm.new(comment_params.merge(user: current_user, post: @post))
      @comment = @comment_form.model
      authorize! :create, @comment
      if @comment_form.save
        render json: @comment
      else
        render json: @comment_form.errors.full_messages, status: :unprocessable_entity
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
      respond_with(@comment.destroy, location: admin_comments_path)
    end

    private

    def set_comment_post
      @post = if params[:action].eql?('create')
                Post.find(params.dig(:comment, :post_id))
              else
                @comment.post
              end
    end

    def comment_params
      params.require(:comment).permit(:text, attachments_attributes: %i[file _destroy id])
    end

    def update_comment_params
      params.require(:comment).permit(:text, images: [], destroy_images: [])
    end
  end
end
