require 'spec_helper'

describe "CoursePages" do
 
  subject { page }

  describe "create course page" do

				before do
					visit new_school_path 
					fill_in "Name", with: "Area 51"
			    click_button "Add a school"
					fill_in "Title", with: "Underwater Basket Weaving"
					fill_in "Course number", with: "UWBW 101"
          select 'Area 51', from: "School"
				end

#          visit new_course_path

  	    it "after saving course" do	
					expect {click_button "Create Class"}.to change(Course, :count).by(1)
				end
	end
end
