class PostsController < ApplicationController
  def index
    topic = Topic.find(params[:topic_id])
    @posts= topic.posts
    @course = Course.find(cookies[:course_id])
    @topics = @course.topics
  end

  def new
    @post = Post.new
    @course = Course.find(cookies[:course_id])
    @topics = @course.topics
  end
  
  def create
    @post = Post.new(post_params)
    topic = Topic.new
    course = Course.find(cookies[:course_id])
    topic.course_id = course.id
    topic.save
    @post.topic_id = topic.id
    if @post.save
      flash[:success] = "Post successfully!"  
      redirect_to action:'index', topic_id:topic.id
    else
      flash[:error] = "Title and Content cannot be blank!"
      redirect_to action:'new'
    end  
  end
  
  private
  def post_params
    params.require(:post).permit(:title,:content)
  end
end
