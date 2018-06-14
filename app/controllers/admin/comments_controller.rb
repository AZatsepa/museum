# frozen_string_literal: true

module Admin
  class CommentsController < ApplicationController
    load_and_authorize_resource
    respond_to :html
    def index; end

    def show; end

    def edit; end
  end
end
