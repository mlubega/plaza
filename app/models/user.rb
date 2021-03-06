class User < ActiveRecord::Base
  
  has_many :posts
  has_many :courses, through: :enrollments
  has_many :enrollments, foreign_key: 'user_id', dependent: :destroy

  before_save { email.downcase! }
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
 
 has_secure_password
 validates :password, length: { minimum: 6 }
 
 def User.new_remember_token
   SecureRandom.urlsafe_base64
 end
 
 def User.hash(token)
   Digest::SHA1.hexdigest(token.to_s)
 end
 
 def enrolled?(course)
   enrollments.find_by_course_id(course.id)
 end
 
 def enroll!(course)
   enrollments.create!(course_id: course.id, user_id: self.id)
 end
 
 # def drop!(course)
 #   enrollments.find_by_course_id(course.id).destroy
 # end
 
 private
  
   def create_remember_token
     self.remember_token = User.hash(User.new_remember_token)
   end
end
