require 'spec_helper'

describe Enrollment do
  let(:user) { FactoryGirl.create(:user) }
  let(:course) { FactoryGirl.create(:course) }
  let(:enrollment) { user.enrollments.build(course_id: course.id) }
  
  subject { enrollment }
  
  it { should be_valid }
  
  describe "user methods" do
    it { should respond_to(:user) }
    it { should respond_to(:course) }
    its(:user) { should eq user }
    its(:course) { should eq course }
  end
  
  describe "when user id is not present" do
    before { enrollment.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when course id is not present" do
    before { enrollment.course_id = nil }
    it { should_not be_valid }
  end
end
