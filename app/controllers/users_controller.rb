class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Sign up successfully! Welcome to Plaza!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end
  
  private
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
    end
end
