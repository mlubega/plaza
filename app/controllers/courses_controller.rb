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
     redirect_to action:'show', id:@course.id
   end
  end

  def show
   @course = Course.find(params[:id])
   @topics = @course.topics
   if params[:topicID]!=nil
     @topic= Topic.find(params[:topicID])
   end
  end
  
  
  private
  def course_params
   params.require(:course).permit(:title, :course_number, :school_id)
  end


end
