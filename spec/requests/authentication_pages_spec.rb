require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }
  describe "signin page" do
    before { visit signin_path }
    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
  
  describe "signin" do
    before { visit signin_path }
    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_link('Sign out',    href: signout_path) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
  
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit edit_user_path(user) }
      it { should_not have_link('Settings',    href: edit_user_path(user)) }
      it { should_not have_link('Sign out',    href: signout_path) }
    end
    
    describe "in Posts controller" do
      describe "submitting to the creat action" do
        before { post posts_path }
        specify { response.should redirect_to(signin_path)}
      end
      describe "submitting to the destroy action" do
        before { delete post_path(FactoryGirl.create(:post)) }
        specify { response.should redirect_to(signin_path)}
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end  
  end
end
