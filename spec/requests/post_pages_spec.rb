require 'spec_helper'

describe "Post pages" do
  
  subject { page }
  
  describe "index post page" do
    before { visit posts_path }
    it { should have_content('Posts List') } 
  end
  
  describe "new post page" do
    before { visit new_post_path }
    it { should have_content('New Post')}
  end
    
  describe "click button of creating new post" do
    before { visit new_post_path }  
    it "should go to posts list" do
      fill_in "Title", with: "my title"
      fill_in "Content", with: "my content"
      click_button "Post!"
      expect(page).to have_content('Posts List') 
    end
  end
  
end
