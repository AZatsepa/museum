# frozen_string_literal: true

module ApplicationHelper
  LOCALES_ICONS = {
    en: 'flag-icon-us',
    uk: 'flag-icon-ua'
  }.freeze

  def add_active_class(path)
    'active' if current_page?(path)
  end

  def present(model, presenter_class = nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model)
    yield(presenter) if block_given?
  end

  def locale_span
    tag :span, class: "flag-icon #{LOCALES_ICONS[I18n.locale]}"
  end
end
