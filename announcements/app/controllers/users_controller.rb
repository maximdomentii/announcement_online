class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Announcements!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find params[:id]

    if @user.update user_params
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    redirect_to users_path
  end

  private

  def user_params
    form_params = {}
    if logged_in? && current_user.role == User.roles[:admin]
      form_params = params.require(:user).permit(:username, :email, :firstname, :lastname, :phone, :password, :password_confirmation, :role)
    else
      form_params = params.require(:user).permit(:username, :email, :firstname, :lastname, :phone, :password, :password_confirmation)
      form_params["role"] = "user"
    end
    form_params
  end
end
