FactoryGirl.define do
  factory :post do
    title   "Example Post"
    content "This is an example post."
    user
    topic
  end
  
  factory :topic do
  end

  factory :user do
    name     "Princess Jasmine"
    email    "aghraba@desert.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :school do
    sequence(:name) {|n| "School #{n}"}
  end

  factory :course do
    sequence (:title) {|n| "Course #{n}" }
    sequence (:course_number) {|n| "CS#{n}" }
    school  
  end

end
