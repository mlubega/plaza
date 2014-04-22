require 'spec_helper'

describe "CoursePages" do
 
  subject { page }

  describe "create course page" do

   			before do
					visit new_course_path 
					click_link "Add Your School"
				end

				
				describe "add a school" do
   				it { should have_content("Enter your school")}	
					before do
						fill_in "Name", with: "Area 51"
					end

          it "should save the school" do
						expect {click_button "Add a school"}.to change(School, :count).by(1)
            current_path.should eq(new_course_path)
					end
				end

			describe "with valid information"  do
     
       let!(:school) { FactoryGirl.create(:school, name: "Area 51" ) }

				before do
          visit new_course_path
					fill_in "Title", with: "Underwater Basket Weaving"
					fill_in "Course number", with: "UWBW 101"
          select 'Area 51', from: "School"
				end

  	    it "after saving course" do	
					expect {click_button "Create Class"}.to change(Course, :count).by(1)
				end
	  	end
	end
end
