class ResultsController < ApplicationController

  def index
    @search_results = Post.search_everywhere(params[:query])
  end

end
