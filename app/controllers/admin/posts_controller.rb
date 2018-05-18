module Admin
  class PostsController < ApplicationController
    load_and_authorize_resource

    def index; end

    def show; end

    def new
      @post.attachments.build
    end

    def edit; end

    def create
      @post = Post.new(post_params.merge!(user: current_user))
      return redirect_to [:admin, @post] if @post.save
      render :new
    end

    def update
      return redirect_to [:admin, @post] if @post.update(post_params)
      render :edit
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, attachments_attributes: %i[file])
    end
  end
end
