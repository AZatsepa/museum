# frozen_string_literal: true

class PostsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show
    @comment_form = CommentForm.new
  end
end
