# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource
  def index; end

  def show; end

  def edit; end

  def update
    redirect_to user_path(@user) if @user.update(users_params)
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :nickname)
  end
end
