class UsersController < ApplicationController
  def new
    redirect_to user_path(current_user) if current_user
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      build_cookie(@user)
      redirect_to user_path(@user)
    else
      flash.now[:notice] = @user.errors.full_messages.first
      render 'users/new'
    end
  end

  def show
    @user = current_user

    if @user.nil? ||
      (cookies[:token] != @user.session_token)
      redirect_to signin_path
    end
  end

  def signin
    @user = User.new
  end
end
