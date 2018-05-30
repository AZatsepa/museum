# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    load_and_authorize_resource
    after_action :publish_post, only: %i[create]

    def index
      @post = Post.new
    end

    def show; end

    def new
      @post.attachments.build
    end

    def edit; end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        render json: @post
      else
        render json: @post.errors.full_messages, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
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
      return if @post.errors.any?
      ActionCable.server.broadcast(
        'posts',
        ApplicationController.render(
          partial: 'posts/post', locals: { post: @post }
        )
      )
    end
  end
end
