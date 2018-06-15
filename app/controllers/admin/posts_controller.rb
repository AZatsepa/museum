# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    load_and_authorize_resource except: %i[index create]
    after_action :publish_post, only: %i[create]
    respond_to :html

    def index
      @posts = Post.all.includes(:user)
      @post_form = PostForm.new
      authorize! :read, @posts
    end

    def show
      @comment_form = CommentForm.new
    end

    def new
      @post_form = PostForm.new
    end

    def edit; end

    def create
      @post_form = PostForm.new(post_params.merge(user: current_user))
      @post = @post_form.model
      authorize! :create, @post
      if @post_form.save
        redirect_to action: :index
      else
        render json: @post_form.errors.messages, status: :unprocessable_entity
      end
    end

    def update
      @post_form = PostForm.new(post_params.merge(model: @post, user: current_user))
      if @post_form.update
        redirect_to action: :show
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
