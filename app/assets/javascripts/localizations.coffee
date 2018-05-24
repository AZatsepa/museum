$(document).on 'load turbolinks:load', ->
  I18n.locale = $('body').data('locale')
