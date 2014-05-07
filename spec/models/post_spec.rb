require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }
  let(:topic) { FactoryGirl.create(:topic)}
  before { @post = user.posts.build(topic_id:topic.id, title:"Example post", content:"just an example post")}
  subject { @post }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id)}
  it { should respond_to(:user) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  its(:user) { should eq user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when topic_id is not present" do
    before { @post.topic_id = nil }
    it { should_not be_valid }
  end
  
  describe "when title blank" do
    before { @post.title = " "}
    it { should_not be_valid }
  end
  describe "when title blank" do
    before { @post.content = " "}
    it { should_not be_valid }
  end
end
