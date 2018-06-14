# frozen_string_literal: true

class PostsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show
    gon.user_role = current_user.present? ? current_user.role : nil
    gon.user_id = current_user.present? ? current_user.id : nil
    @comment_form = CommentForm.new
  end
end
