class Course < ActiveRecord::Base
  
    belongs_to :user
    belongs_to :school
    has_many :topics
    validates :title, presence: true
    validates :course_number, presence: true
end
