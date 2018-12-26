# frozen_string_literal: true

module Admin
  class PostsController < ApplicationController
    load_and_authorize_resource except: %i[index create]
    after_action :publish_post, only: %i[create]
    respond_to :html

    def index
      @posts = Post.all
      @post_form = PostForm.new
      authorize! :read, @posts
    end

    def show
      @post = Post.with_attached_images.find(params[:id])
      authorize! :read, @post
      @json_comments = @post.comments
                            .includes(:images_attachments, :user)
                            .map(&CommentSerializer.method(:new))
                            .to_json
    end

    def new
      @post = Post.new
    end

    def edit
      @post = Post.with_attached_images.find(params[:id])
      authorize! :edit, @post
    end

    def create
      @post = Post.new(post_params.merge(user: current_user))
      authorize! :create, @post
      respond_to do |format|
        if @post.save
          format.json { render json: @post }
        else
          format.json { render json: @post.errors.messages, status: :unprocessable_entity }
        end
      end
    end

    def update
      @post_form = PostForm.new(update_post_params.merge(post: @post, user: current_user))
      respond_to do |format|
        if @post_form.update
          format.json { render json: @post, location: admin_post_path(@post) }
        else
          format.json { render json: @post_form.errors.messages, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post.destroy
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, images: [])
    end

    def update_post_params
      params.require(:post).permit(:title, :body, images: [], destroy_images: [])
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
