# frozen_string_literal: true

class PagesController < ApplicationController
  def main; end

  def index
    return @posts = Post.all.order('created_at DESC') unless params[:search]

    @posts = Post.search(params[:search]).order('created_at DESC')
  end

  def feeds; end

  def about; end
end
