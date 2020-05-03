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
    tag.span class: "flag-icon #{LOCALES_ICONS[I18n.locale]}"
  end

  def nav_activable_link_to(name, path)
    link_to name, path, class: "nav-link #{add_active_class(path)}"
  end

  def sort_order
    params[:direction] == 'asc' ? 'desc' : 'asc'
  end

  def sort_icon(order)
    return unless order.to_s == params[:order]

    icon = sort_order == 'asc' ? 'fa-sort-amount-desc' : 'fa-sort-amount-asc'
    tag(:span, class: "fa #{icon}")
  end

  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info alert-dismissible fade show'
    when :success then 'alert alert-success alert-dismissible fade show'
    when :error then 'alert alert-warning alert-dismissible fade show'
    when :alert then 'alert alert-danger alert-dismissible fade show'
    end
  end
end
