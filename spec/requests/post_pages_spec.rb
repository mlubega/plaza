require 'spec_helper'

describe "Post pages" do
  
  subject { page }
  
  describe "posts" do
    before { visit posts_path }
    it { should have_content('Posts List') } 
  end
  
  describe "create post" do
    before { visit new_post_path }
    it { should have_content('New Post')}
    
    it "should go to posts lists" do
      click_button "Post!"
      expect(page).to have_content('Posts List') 
    end
  end
  
end
