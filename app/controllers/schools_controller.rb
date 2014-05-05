class SchoolsController < ApplicationController
  def new
   @school = School.new
  end
  
  def create
    if params[:school][:going_to_list_courses]
      redirect_to controller:'courses',action:'index',school_id:params[:school][:school_id]
    else
      @school = School.new(school_params)
      if !@school.save
        render 'new'
      else
        redirect_to controller: "courses", action: "new"
      end
    end
  end

  def index
   @schools = School.all
  end

  private
  def school_params
   params.require(:school).permit(:name)
  end

end
