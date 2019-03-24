class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    if !current_user
      redirect_to root_path
    end
  end

  def update
    if !current_user || !current_user.is_admin
      redirect_to root_path
    else
      @user = User.find(params[:id])

      if @user.update(user_params)
        flash[:save] = "User successfully saved!"
        redirect_to view_user_path(:id => @user.id)
      else
        flash[:save] = "Something went wrong, check the logs or contact the system administrator!"
        redirect_to view_user_path(:id => @user.id)
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :id, :active, :is_admin)
  end
end
