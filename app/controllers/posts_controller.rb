# frozen_string_literal: true

class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = @posts.includes(:rich_text_body)
  end

  def show; end
end
