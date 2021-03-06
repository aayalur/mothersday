class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user.admin?
      session[:user_id] = user.id
      redirect_to admin_path
    elsif user.approved == false
      flash.now.alert = "You have not been approved yet."
      render "new"
    elsif user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
  		flash.now.alert = "Invalid email or password"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Logged out!"
  end
end
