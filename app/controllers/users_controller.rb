class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    authorize @user
  end
end
