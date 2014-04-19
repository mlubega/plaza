class Course < ActiveRecord::Base
    belongs_to :school
    validates :title, presence: true
    validates :course_number, presence: true
end
