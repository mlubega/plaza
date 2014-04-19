class SchoolsController < ApplicationController
  def new
   @school = School.new
  end
  
  def create
  end

  def index
   @schools = Schools.all
  end

  private
  def school_params
   params.require(:school).permit(:name)
  end

end
