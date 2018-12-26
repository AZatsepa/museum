# frozen_string_literal: true

class PostsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show
    @post = Post.with_attached_images.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, images: %i[])
  end
end
