class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])

    if @user
      log_in(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid login"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end
end
