class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Sign up successfully! Welcome to Plaza!"
      redirect_to controller:'static_pages', action:'home'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Info updated successfully!"
      redirect_to controller:'static_pages', action:'home'
    else
      render 'edit'
    end
  end
  
  private
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end  
end
