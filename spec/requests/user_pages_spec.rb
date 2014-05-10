require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
    
    it { should have_content('Create')}
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user) 
    end
    describe "page" do
      it { should have_content('Update') }
      it { should have_title('Edit')}
    end
    
    describe "with invalid information" do
      
      before { click_button "Save" }
      
      it { should have_content('error') }
    end
  end 
  
  describe "drop a cousrse" do
    let(:teacher) { FactoryGirl.create(:user) }
    before do 
      sign_in(teacher)
  		visit new_school_path 
  		fill_in "Name", with: "UW-Madison"
      click_button "Add a school"
  		fill_in "Title", with: "Math"
  		fill_in "Course number", with: "217"
      select 'UW-Madison', from: "School"
      click_button "Create Class"
      visit root_path
      click_link "Settings"
    end
    describe "drop a course" do
      let(:student) { FactoryGirl.create(:user) }
      before do 
        sign_in(student)
        visit root_path
        click_link "Join a course"
        select 'UW-Madison', from: "School"
        click_button 'Select'
        select 'Math', from: 'Course'
        click_button 'Select'
        click_link "Settings"
      end
      it { should have_link("drop") }
      it "should drop a course" do
        expect {click_link "drop"}.to change(student.courses, :count)
      end
    end   
    
    

    
  end 
  

end
