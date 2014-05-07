class Post < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :user
  
  validates :user_id, presence: true
  validates :topic_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  
end
