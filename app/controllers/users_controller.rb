class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      user = User.new(username: params[:user][:username])
      
      if !user.save
        flash[:error] = "Unable to login."
        redirect_to root_path
        return
      else
        puts "****** NEW USER"
        flash[:welcome] = "Welcome to Media Ranker, #{user.username}!"
      end
    else
      puts "****** RETURN USER"
      flash[:welcome] = "Welcome back, #{user.username}!"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end
end
