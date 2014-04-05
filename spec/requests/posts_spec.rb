require 'spec_helper'

describe "Posts" do
  
  describe "Posts List page" do
    it "should have the content 'Posts List'" do
      visit posts_path
      expect(page).to have_content('Posts List')
    end
  end
      
end
