module Admin
  class PostsController < ApplicationController
    load_and_authorize_resource
    after_action :publish_post, only: %i[create]
    # respond_to :json

    def index
      @post_form = PostForm.new
      @post = Post.new
    end

    def show; end

    def new
      @post_form = PostForm.new
      @post.attachments.build
    end

    def edit; end

    def create
      @post_form = PostForm.new(post_params.merge(current_user: current_user))
      @post_form.save
      if @post_form.save
        render json: @post = @post_form.post
      else
        render json: @post_form.errors.messages, status: :unprocessable_entity
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
      object_params = params[:post] || params.require(:post_form)
      object_params.permit(:title, :body, attachments_attributes: %i[file _destroy id])
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
