class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    if params[:course][:going_to_a_course]
      course_id = params[:course][:course_id]
      course = Course.find(course_id)
      course.user = current_user
      course.save
      redirect_to action:'show', id:course_id, fromDropdownMenu:true
    else
      @course = Course.new(course_params)
      @course.user = current_user
      if !@course.save
        render 'new'
      else
        flash.now[:success] = "Course created successfully!"
        redirect_to action:'show', id:@course.id, fromCreateACourse:true
      end
    end
  end
  
  def index
    school = School.find(params[:school_id])
    @courses = school.courses
  end

  def show
    if params[:fromCourseLink] || params[:fromCreateACourse] || params[:fromDropdownMenu]
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
