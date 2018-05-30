# frozen_string_literal: true

class ResultsController < ApplicationController
  def index
    @search_results = Post.search_everywhere(params[:query])
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname)
  end
end
