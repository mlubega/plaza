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
  

end
