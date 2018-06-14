# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    load_and_authorize_resource
    def index; end
  end
end
