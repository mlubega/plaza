class PostsController < ApplicationController
  def index
    topic = Topic.find(params[:topic_id])
    @posts= topic.posts
    @course = Course.find(cookies[:course_id])
    @topics = @course.topics.newest_first
  end


  def new
    if params[:fromCommentLink]
      @topic = Topic.find(params[:topic_id])
      @posts= @topic.posts
    end
    @post = Post.new
    @course = Course.find(cookies[:course_id])
    @topics = @course.topics.newest_first
  end
  
  def create
    if topic_id = params[:post][:topic_id]
      topic = Topic.find(topic_id)
    else
      topic = Topic.new
    end
    @post = Post.new(post_params)
    course = Course.find(cookies[:course_id])
    topic.course_id = course.id
    if @post.save
      topic.save
      @post.topic_id = topic.id
      @post.save
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
