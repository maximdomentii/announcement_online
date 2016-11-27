class SessionsController < ApplicationController
  @@from_add_ann = nil

  def new
    if params[:from_add_ann] == true.to_s
      @@from_add_ann = true
    end

  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user

      if @@from_add_ann == true
        redirect_to new_announcements_path
      else
        redirect_to root_path
      end

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
