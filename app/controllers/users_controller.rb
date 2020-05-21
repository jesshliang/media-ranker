class UsersController < ApplicationController
  
  before_action :require_login, only: [:index, :show]
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:invalid] = 'User not found'
      redirect_to users_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: user_params[:username])

    if user.nil?
      user = User.new(username: user_params[:username])
      
      if !user.save
        flash[:error] = "Unable to login."
        redirect_to root_path
        return
      else
        flash[:welcome] = "Welcome to Media Ranker, #{user.username}!"
      end
    else
      flash[:welcome] = "Welcome back, #{user.username}!"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])

      if user != nil
        session[:user_id] = nil
        flash[:notice] = "#{user.username} has been logged out!"
      else
        session[:user_id] = nil
        flash[:notice] = "Error: Not a known user."
      end
    else
      flash[:error] = "No user was logged in."
    end

    redirect_to root_path
  end

  private 

  def user_params
    return params.require(:user).permit(:username)
  end

end
