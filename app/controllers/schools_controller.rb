class SchoolsController < ApplicationController
  def new
   @school = School.new
  end
  
  def create
   @school = School.new(school_params)
   if !@school.save
     render 'new'
   else
     redirect_to controller: "courses", action: "new"
   end
  end

  def index
   @schools = Schools.all
  end

  private
  def school_params
   params.require(:school).permit(:name)
  end

end
