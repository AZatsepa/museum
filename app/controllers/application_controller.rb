# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  protect_from_forgery with: :exception
  before_action :set_locale, :set_abilities
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_path, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name nickname])
  end

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_abilities
    gon.abilities = current_ability.as_json
    gon.current_user = current_user.as_json
  end

  def set_locale
    I18n.locale = extract_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    return parsed_locale if I18n.available_locales.map(&:to_s).include?(parsed_locale)

    extract_locale_from_header || I18n.locale
  end

  def extract_locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/[a-z]{2}/)&.map(&:to_sym)&.find do |locale|
      I18n.available_locales.include?(locale)
    end
  end

  def current_ability
    Ability.new(current_user)
  end

  def sort_params
    if params[:order].present?
      { params[:order] => (params[:direction].presence || 'asc') }
    else
      { id: :asc }
    end
  end
end
