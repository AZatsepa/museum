# frozen_string_literal: true

class PersonalitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @personalities = @personalities.published.order(sort_params).page(params[:page])
  end

  def show
    @personality = Personality.published.find(params[:id])
    authorize!(:read, @personality)
  end

  def new; end

  def edit; end

  def create
    @personality = Personality.new(personality_params.merge(user: current_user))
    authorize!(:create, @personality)
    render(:new) && return unless @personality.save
    if @personality.published?
      redirect_to @personality, flash: { notice: t('personalities.create.success') }
    else
      redirect_to personalities_path, flash: { notice: t('personalities.create.unpublished') }
    end
  end

  def update
    render(:edit) && return unless @personality.update(personality_params)
    if @personality.published?
      redirect_to @personality, flash: { notice: t('personalities.update.success') }
    else
      redirect_to personalities_path, flash: { notice: t('personalities.update.unpublished') }
    end
  end

  def destroy
    @personality.destroy
    redirect_to personalities_path, flash: { notice: t('personalities.destroy.success') }
  end

  private

  def personality_params
    params
      .require(:personality)
      .permit(
        :name,
        :life_years,
        :information,
        :definition,
        :published,
        :image
      )
  end
end
