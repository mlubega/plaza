class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
   @course = Course.new(course_params)
   @course.user = current_user
   if !@course.save
     render 'new'
   else
     flash.now[:success] = "Course created successfully!"
     redirect_to action:'show', id:@course.id, fromCreateACourse:true
   end
  end

  def show
    if params[:fromCourseLink] || params[:fromCreateACourse]
      cookies.permanent[:course_id] = params[:id]
    end
    @course = Course.find(cookies[:course_id])
    @topics = @course.topics
  
  end
  
  
  private
  def course_params
    params.require(:course).permit(:title, :course_number, :school_id)
  end


end
