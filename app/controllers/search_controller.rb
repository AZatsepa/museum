# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @posts = Post.search_everywhere(params[:query])
    render 'posts/index'
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname)
  end
end
