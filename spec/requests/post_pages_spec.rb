require 'spec_helper'

describe "Post pages" do
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  course = Course.create(title:'Math',course_number:'217')
  before do 
    sign_in user 
    user.enroll!(course)
    visit root_path
    click_link "#{course.title} #{course.course_number}"
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
