class SessionsController < ApplicationController
  def new
    @session = User.new
  end

  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      build_cookie(user)
      redirect_to user_path(user)
    else
      flash.now[:notice] = "Email/Password incorrect"
      @session = user || User.new
      render 'sessions/new'
    end
  end

  def destroy
    user = current_user

    user.update_attributes(session_token: nil)

    cookies[:token] = nil
    cookies[:user_id] = nil

    redirect_to articles_path
  end
end
