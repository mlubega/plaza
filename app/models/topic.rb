class Topic < ActiveRecord::Base
  
  has_many :posts, dependent: :destroy
  belongs_to :course
  
  scope :newest_first, lambda { order("topics.created_at DESC")}
end
