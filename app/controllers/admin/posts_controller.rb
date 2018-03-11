module Admin
  class PostsController < ApplicationController
    http_basic_authenticate_with name: ENV['ADMIN_AUTH_NAME'], password: ENV['ADMIN_AUTH_PASSWORD']
    before_action :find_post, except: %i[index new create]

    def index
      @posts = Post.all
    end

    def show; end

    def new
      @post = Post.new
    end

    def edit; end

    def create
      @post = Post.create(post_params)
      return redirect_to [:admin, @post] if @post.save
      render 'new'
    end

    def update
      return redirect_to [:admin, @post] if @post.update(post_params)
      render 'edit'
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path
    end

    private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def find_post
      @post = Post.find(params[:id])
    end
  end
end