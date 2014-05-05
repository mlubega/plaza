class Course < ActiveRecord::Base
  
    has_many :users, through: :enrollments
    belongs_to :school
    has_many :topics
    has_many :enrollments, foreign_key: 'course_id', dependent: :destroy
    
    validates :title, presence: true
    validates :course_number, presence: true
end
