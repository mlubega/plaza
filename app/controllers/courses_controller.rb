class CoursesController < ApplicationController
  def new
   @course = Course.new
  end

  def create
   @course = Course.new(course_params)
   if !@course.save
     render 'new'
   else
     flash.now[:success] = "Course created successfully!"
     render 'show'
   end
  end

  def show
   @course = Course.find(params[:id])
  end
  
  private
  def course_params
   params.require(:course).permit(:title, :course_number, :school_id)
  end


end
