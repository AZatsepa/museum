# frozen_string_literal: true

module Admin
  class MarkdownController < ApplicationController
    layout false
    def preview
      render html: params[:data].html_safe
    end
  end
end
