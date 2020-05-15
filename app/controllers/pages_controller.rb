# frozen_string_literal: true

class PagesController < ApplicationController
  def main; end

  def index
    return @posts = Post.all.order('created_at DESC') unless params[:search]

    @posts = Post.search(params[:search]).order('created_at DESC')
  end

  def feeds; end

  def sitemap
    respond_to do |format|
      format.xml { render file: 'public/sitemaps/sitemap.xml' }
      format.html { redirect_to root_url }
    end
  end

  def robots
    @posts = Post.where(published: false)
    @personalities = Personality.where(published: false)
  end

  def about; end
end
