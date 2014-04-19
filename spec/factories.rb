FactoryGirl.define do
  factory :post do
    title   "Example Post"
    content "This is an example post."
  end

  FactoryGirl.define do
   factory :user do
    name     "Princess Jasmine"
    email    "aghraba@desert.com"
    password "foobar"
    password_confirmation "foobar"
  end
 end
end
