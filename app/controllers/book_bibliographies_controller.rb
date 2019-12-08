# frozen_string_literal: true

class BookBibliographiesController < ApplicationController
  load_and_authorize_resource

  def index
    @book_bibliographies = BookBibliography
                           .published
                           .order(sort_params)
                           .page(params[:page])
  end

  def show
    @book_bibliography = BookBibliography.published.find(params[:id])
  end

  def new; end

  def create
    @book_bibliography = current_user.book_bibliographies.build(book_bibliography_params)
    authorize! :create, @book_bibliography
    render :new and return unless @book_bibliography.save # rubocop:disable Style/AndOr

    if @book_bibliography.published.present?
      redirect_to @book_bibliography, notice: t('book_bibliography.notice.created')
    else
      render action: :index, notice: t('book_bibliography.notice.unpublished')
    end
  end

  def edit; end

  def update
    if @book_bibliography.update(book_bibliography_params)
      redirect_to @book_bibliography
    else
      render :edit
    end
  end

  def destroy
    @book_bibliography.destroy
    render action: :index
  end

  private

  def book_bibliography_params
    params
      .require(:book_bibliography)
      .permit(:authors, :title, :publishing_year, :events_years, :page, :annotation, :published)
  end

  def sort_params
    if params[:order].present?
      { params[:order] => (params[:direction].presence || 'asc') }
    else
      { id: :asc }
    end
  end
end
