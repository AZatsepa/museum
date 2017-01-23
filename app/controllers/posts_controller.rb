class PostsController < ApplicationController
  def index
  if params[:search]
    @posts = Post.search(params[:search]).order("created_at DESC")
  else
    @posts = Post.all.order('created_at DESC')
  end
end
end
