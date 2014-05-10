require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com",
                           password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token)}
  it { should respond_to(:authenticate)}
  it { should respond_to(:enrollments)}
  it { should respond_to(:courses)}
  it { should respond_to(:enroll!)}
  it { should respond_to(:enrolled?)}
  # it { should respond_to(:drop!)}
  it { should respond_to(:posts)}
  
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "enroll" do
    let(:course) { FactoryGirl.create(:course)}
    before do
      @user.save
      @user.enroll!(course)
    end
    it { should be_enrolled(course) }
    its(:courses) { should include(course) }
    
    # describe "and drop" do
    #   before { @user.drop!(course)}
    #   it { should_not be_enrolled(course)}
    #   its(:courses) { should_not include(course) }
    # end
  end
end
