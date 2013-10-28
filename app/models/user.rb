class User < ActiveRecord::Base
  belongs_to :profile
  belongs_to :school_semester

  has_many :presurvey_part1s, :through => :school_semester, :class_name => "Presurvey::Part1"
  has_many :presurvey_part2s, :through => :school_semester, :class_name => "Presurvey::Part2"
  has_many :efficacies, :through => :presurvey_part2s
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

  def pendingUser?
    if PendingUser.find_by_user_id(id); true
    else; false; end
  end

end
