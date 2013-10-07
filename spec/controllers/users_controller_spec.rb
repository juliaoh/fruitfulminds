require 'spec_helper'

describe UsersController do
  context "user registration fails due to unsuccessful user object creation in db" do
    before :each do
      @user = {
        :firstname => "Amir",
        :lastname => "Khodaei",
        :college => "Berkeley City",
        :email => "amirk88@gmail.com",
        :password => "password",
        :confirm_password => "password"}
      @school = {
        :name => "Haven Elementary",
        :city => "Berkeley",
        :county => "Alameda"}
      @semester = {
        :name => "Fall",
      }
      @date = {
        :year => "2012"
      }
    end
    it "should set @user to nil if a db failure occurs inside the transaction" do
      User.stub(:create).and_return(mock('user'))
      PendingUser.stub(:create).and_raise(SQLite3::SQLException)
      post :create, {:user => @user, :school => @school, :semester => @semester, :date => @date, :tos => true}
      assigns(:user).should == nil
    end
=begin
    it "should set flash warning and redirect to signup page" do
# school = mock('school')
#      school.stub(:id).and_return(1)
      school_semesters = mock('school_semester')
      school_semester = mock('school_semester')
      school_semester.stub(:id).and_return(1)
      profile = mock('profile')
      profile.stub(:id).and_return(2)
      School.stub(:where).and_return([school])
      SchoolSemester.stub(:where).and_return(school_semesters)
      school_semesters.stub(:order).and_return([school_semester])
      Profile.stub(:find_by_label).and_return(profile)
      User.stub(:create).and_return(nil)
      post :create, {:user => @user, :school => @school, :semester => @semester, :tos => true}
      flash[:warning].should == "Registration Failed"
      response.should redirect_to(signup_path)
    end
    it "should set flash warning to school not found if school is nil" do
      School.stub(:where).and_return([])
      post :create, {:user => @user, :school => @school, :semester => @semester, :tos => true}
      flash[:warning].should == "Haven's Elementary school could not be found"
      response.should redirect_to(signup_path)
    end
    it "should set flash warning to registration not allowed for wrong semester" do
      school = mock('school')
      school.stub(:id).and_return(1)
      school.stub(:name).and_return("some school")
      school_semesters = mock('school_semester')
      School.stub(:where).and_return([school])
      SchoolSemester.stub(:where).and_return(school_semesters)
      school_semesters.stub(:order).and_return([])
      post :create, {:user => @user, :school => @school, :semester => @semester, :tos => true}
      flash[:warning].should == "Registration is not allowed for the selected semester for some school school"
      response.should redirect_to(signup_path)
    end
=end
  end
end
