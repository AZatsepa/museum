# frozen_string_literal: true

module Admin
  class MarkdownController < ApplicationController
    def preview
      @text = params[:data]
    end
  end
end
