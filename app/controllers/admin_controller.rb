class AdminController < ApplicationController

  def show
    if !current_user || !current_user.is_admin
      redirect_to root_path
    else
      @all_users = User.all
    end
  end

  def view_user
    if !current_user || !current_user.is_admin
      redirect_to root_path
    else
      @user = User.find(params[:id])
    end
  end
end
