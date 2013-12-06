require 'spec_helper'

describe User do
  before(:all) do
    School.create!(:name=>"school", :county=>"county", :city=>"city", :district=>"district")
    Course.create!(:semester => "Fall 2013", :total_students => 3, :school_id => 1, :curriculum_id => 1, :presurvey_id => 1, :postsurvey_id => 1, :active => 1)
    @ambassador = User.new(:name=>"ASD", :email => "ASD", :password=> "ASDFGH", :profile =>"ambassador", :pending=>1, :course_ids=>[1])
    @admin = User.new(:name=>"ASD", :email => "ASD", :password=> "ASDFGH", :profile =>"admin", :pending=>1, :course_ids=>[1])
  end
  it 'should return ambassador' do
    @ambassador.admin?.should be false
  end
  it 'should return ambassador' do
    @admin.admin?.should be true
  end
  it 'should return courses' do
    @admin.courses.size.should be 1
  end
end
