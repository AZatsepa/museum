module Admin
  class MarkdownController < ApplicationController
    def preview
      @text = params[:data]
    end
  end
end
