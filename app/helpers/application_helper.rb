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

  def nav_activable_link_to(name, path)
    link_to name, path, class: "nav-link #{add_active_class(path)}"
  end

  def sort_order
    params[:direction] == 'asc' ? 'desc' : 'asc'
  end

  def sort_icon(title, order)
    return title unless order.to_s == params[:order]

    icon = sort_order == 'asc' ? 'fa-sort-amount-desc' : 'fa-sort-amount-asc'
    content_tag :div, class: 'd-flex justify-content-between' do
      content_tag(:span, title) +
        tag(:span, class: "fa #{icon}")
    end
  end
end
