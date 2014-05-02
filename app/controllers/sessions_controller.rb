class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to controller:'static_pages', action:'home'
    else
      flash.now[:error] = "Invalid email/passord combination"
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
