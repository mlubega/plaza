class PostsController < ApplicationController
  
  before_action :signed_in_user
  before_action :correct_user, only: :destroy
  
  def index
    if topic = Topic.find_by_id(params[:topic_id])
      @posts= topic.posts
    end
    @course = Course.find(cookies[:course_id])
    @creator = User.find(@course.creator_id)
    @topics = @course.topics.newest_first
  end


  def new
    if params[:commenting]
      @topic = Topic.find(params[:topic_id])
      @posts= @topic.posts
      @commenting = true
    end
    @post = Post.new
    @course = Course.find(cookies[:course_id])
    @creator = User.find(@course.creator_id)
    @topics = @course.topics.newest_first
  end
  
  def create
    if params[:post][:commenting]
      topic_id = params[:post][:topic_id]
      topic = Topic.find(topic_id)
    else
      course = Course.find(cookies[:course_id])
      topic = course.topics.create
      created_a_new_topic = true
    end
      @post = topic.posts.build(post_params)
      @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Post successfully!"  
      redirect_to action:'index', topic_id:topic.id
    else
      # post is not saved successfully but a new topic is already saved so we should
      if created_a_new_topic 
        topic.destroy 
      end
      flash[:error] = "Title and Content cannot be blank!"
      if params[:post][:commenting]
        redirect_to action:'new',commenting:true,topic_id:topic.id
      else
        redirect_to action:'new'
      end
    end  
  end
  
  def destroy
    post = Post.find(params[:id])

    topic = Topic.find(post.topic.id)
    post.destroy
    if topic.posts.count == 0
      topic.destroy
      redirect_to controller:'courses', action:'show'
    else
      redirect_to action:'index',topic_id: post.topic.id
    end
  end
  
  private
    def post_params
      params.require(:post).permit(:title,:content)
    end
    
    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_path if !@post
    end
  

end
