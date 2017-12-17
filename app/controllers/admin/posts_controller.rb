module Admin
  class PostsController < ApplicationController
    http_basic_authenticate_with name: ENV['ADMIN_AUTH_NAME'], password: ENV['ADMIN_AUTH_PASSWORD']

    def index
      @posts = Post.all
    end

    def show
      @post = Post.find(params[:id])
      @comments = Comment.where(post_id: @post.id)
    end

    def new
      @post = Post.new
    end

    def edit
      @post = Post.find(params[:id])
    end

    def create
      @post = Post.create(post_params)
      if @post.save
        redirect_to [:admin, @post]
      else
        render @post.errors
      end
    end

    def update
      @post = Post.find(params[:id])

      if @post.update(post_params)
        redirect_to [:admin, @post]
      else
        render 'edit'
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy

      redirect_to admin_posts_path
    end

    private

    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
end
