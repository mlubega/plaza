require 'spec_helper'

describe "Post pages" do
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before do 
    sign_in(user)
		visit new_school_path 
		fill_in "Name", with: "UW-Madison"
    click_button "Add a school"
		fill_in "Title", with: "Math"
		fill_in "Course number", with: "217"
    select 'UW-Madison', from: "School"
    click_button "Create Class"
    click_link "Math 217"
  end
  
  describe "post creation" do
    describe "with blank title or content" do
      before do
        click_link "New post"
        click_button "Post"
      end
      it "should not create a post" do
        expect {click_button "Post"}.not_to change(Post, :count)
      end
      it "should not create a topic" do
        expect {click_button "Post"}.not_to change(Topic, :count)
      end
      it { should have_content('blank')}
    end
    describe "with valid content" do
      before do
        click_link "New post"
        fill_in "Title", with: "my title"
        fill_in "Content", with: "my content"
      end
      it "should create a post" do
        expect {click_button "Post"}.to change(Post, :count)
      end
    end
  end
end
