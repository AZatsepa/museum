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
  end

  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :nickname)
  end
end