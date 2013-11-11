require 'spec_helper'

describe User do
  before(:all) do
    Profile.create!(:label=>"admin")
    Profile.create!(:label=>"ambassador")
    @ambassador = User.new(:profile_id => 2, :name=>"ASD", :email => "ASD", :password=> "ASDFGH")
    @admin = User.new(:profile_id => 1, :name=>"ASD", :email => "ASD", :password=> "ASDFGH")
    School.create!(:name=>"school", :county=>"county", :city=>"city", :district=>"district")
    Course.create!(:semester => "semester", :total_students => 3, :school_id => 1, :curriculum_id => 1, :presurvey_id => 1, :postsurvey_id => 1)
  end
  it 'should return ambassador' do
    @ambassador.ambassador?.should be true
  end
  it 'should return ambassador' do
    @admin.admin?.should be true
  end
  it 'should return schools' do
    @admin.schools.size.should be 1
  end
  it 'should return courses' do
    @admin.courses.size.should be 1
  end
end
