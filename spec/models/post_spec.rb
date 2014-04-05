require 'spec_helper'

describe Post do
  before { @post = Post.new(title:"Example post", content:"just an example post")}
  subject { @post }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  
  describe "when title blank" do
    before { @post.title = " "}
    it { should_not be_valid }
  end
  describe "when title blank" do
    before { @post.content = " "}
    it { should_not be_valid }
  end
end
