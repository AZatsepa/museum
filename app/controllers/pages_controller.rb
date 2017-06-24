class PagesController < ApplicationController
  def index
    return @posts = Post.all.order('created_at DESC') unless params[:search]
    @posts = Post.search(params[:search]).order('created_at DESC')
  end

  def about; end
end
