require 'spec_helper'

describe Course do

  let(:school) {FactoryGirl.create(:school)}

  before do 
     @course = school.courses.build(title: "Hindi", course_number: "HI336")
  end


  subject { @course }
 
  it {should respond_to(:title)}
  it {should respond_to(:course_number)}
  it {should respond_to(:school)}
  it {should respond_to(:school_id)}
  
  it {should be_valid}

end
