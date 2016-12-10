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

    if params[:from] == 'user_list'
      if @user.save
        flash[:success] = "User #{@user.username} successfully added!"
        redirect_to users_path
      else
        render 'new'
      end
    else
      if @user.save
        log_in @user
        flash[:success] = 'Welcome to the Announcements!'
        redirect_to root_path
      else
        render 'new'
      end
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

    if params[:to] == 'home_page'
      redirect_to root_path
    else
      redirect_to users_path
    end

  end

  def new_edit_name
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render :edit_name }
    end
  end

  def new_edit_username
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render :edit_username }
    end
  end

  def new_edit_phone
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render :edit_phone }
    end
  end

  def new_edit_email
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render :edit_email }
    end
  end

  def new_edit_password
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render :edit_password }
    end
  end

  def edit_name
    @user = User.find params[:id]

    edit_param @user, 'Your firsname and lastname successfully updated!', 'Error updating your firsname and lastname!'
  end

  def edit_username
    @user = User.find params[:id]

    edit_param @user, 'Your username successfully updated!', 'Error updating your username!'
  end

  def edit_phone
    @user = User.find params[:id]

    edit_param @user, 'Your phone successfully updated!', 'Error updating your phone!'
  end

  def edit_email
    @user = User.find params[:id]

    if @user.authenticate(user_params[:password])
      edit_param @user, 'Your email successfully updated!', 'Error updating your email!'
    else
      edit_param_error @user, 'Invalid password!'
    end
  end

  def edit_password
    @user = User.find params[:id]

    if @user.authenticate(edit_password_param_check)
      if params[:user][:password] == params[:user][:password_confirmation]
        if params[:user][:old_password] != params[:user][:password]
          edit_param @user, 'Your password successfully updated!', 'Error updating your password!'
        else
          edit_param_error @user, 'Old and new passwords have to be different!'
        end
      else
        edit_param_error @user, 'Different password confirmation from new password!'
      end
    else
      edit_param_error @user, 'Invalid password!'
    end
  end

  def delete_my_account
    byebug
    @user = User.find params[:id]
    @user.destroy

    redirect_to root_path
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

  def edit_password_param_check
    form_params = {}

    form_params["password"] = params[:user][:old_password]
  end

 def edit_param user, success_message, error_message
    if user.update(user_params)
      flash[:success] = success_message
    else
      flash[:danger] = error_message
    end
    redirect_to user
  end

  def edit_param_error user, error_message
    flash[:danger] = error_message
    redirect_to user
  end
end
