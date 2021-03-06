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
      flash[:success] = "Sign up successfully! Welcome to Plaza #{@user.name}!"
      redirect_to controller:'static_pages', action:'home'
    else
      render 'new'
    end
  end
  
  def drop 
    course_to_drop = Course.find(params[:course_id])
    course_creator = User.find(course_to_drop.creator_id)
    enrollment = current_user.enrollments.find_by(course_id: course_to_drop.id)
    enrollment.destroy
    if course_creator == current_user || current_user.id == 1 # The first user have be able to delete any course once they join the course.
      course_to_drop.destroy
    end
    @enrolled_courses = current_user.courses
    @user = current_user
    render 'edit'
  end

  def show
  end

  def edit
    @enrolled_courses = current_user.courses
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Info updated successfully!"
      redirect_to controller:'static_pages', action:'home'
    else
      @enrolled_courses = current_user.courses
      render'edit'
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
