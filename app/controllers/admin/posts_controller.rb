# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    load_and_authorize_resource
    after_action :publish_post, only: %i[create]

    def index
      @post_form = PostForm.new
      @post = Post.new
    end

    def show; end

    def new
      @post_form = PostForm.new
    end

    def create
      @post_form = PostForm.new(post_params.merge(current_user: current_user))
      if @post_form.save
        render json: @post = @post_form.object
      else
        render json: @post_form.errors.messages, status: :unprocessable_entity
      end
    end

    def update
      @post_form = PostForm.new(post_params.merge(object: @post, current_user: current_user))
      if @post_form.update
        redirect_to admin_post_path(@post_form.object)
      else
        render json: @post_form.errors.messages, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, attachments_attributes: %i[file _destroy id])
    end

    def publish_post
      return if @post_form.errors.any?
      ActionCable.server.broadcast(
        'posts',
        ApplicationController.render(
          partial: 'posts/post', locals: { post: @post }
        )
      )
    end
  end
end
