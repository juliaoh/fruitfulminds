class User < ActiveRecord::Base
  belongs_to :profile
  belongs_to :school_semester

  has_and_belongs_to_many :courses

  has_many :presurveys, :through => :school_semester
  has_many :efficacies, :through => :presurveys
  has_many :postsurveys, :through => :school_semester
  has_many :food_journals, :through => :school_semester

  delegate :label, :to => :profile, :prefix => true

  has_secure_password
  validate :name, :presence => true
  validate :email, :presence => true, :uniqueness => true
  validate :password, :presence => true, :on => :create, :length => {:minimum => 6}

  strip_attributes

  def admin?
    profile_label == Profile::ADMIN
  end

  def ambassador?
    profile_label == Profile::AMBASSADOR
  end

  def school
    school_semester.school if school_semester
  end

  def schools
    user_schools = []
    if admin?
      user_schools = School.all
    else
      user_schools << school if !school.nil?
    end
    user_schools
  end

  def courses
    user_courses = []
    if admin?
      user_courses = Course.all
    else
      #set user_courses to be the users' courses
    end
    user_courses
  end

  def pendingUser?
    if PendingUser.find_by_user_id(id); true
    else; false; end
  end

end
