class User < ActiveRecord::Base
  belongs_to :college
  has_and_belongs_to_many :courses
  has_secure_password
  validate :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validate :password, :presence => true, :on => :create, :length => {:minimum => 6}
  validate :profile, :presence => true, :inclusion => ["ambassador", "admin"]
  validate :pending, :presence => true, :inclusion => [0, 1, 2]
  # pending = 0, active = 1, inactive = 2
  before_save :test
  strip_attributes

  def test
    self.college ||= College.find_by_id(1)
  end

  def admin?
    profile == "admin"
  end

  def pending_course
    Course.find_by_id(@pending_course_id)
  end

  def courses
    courses = Course.all
    if not admin?
      user_courses = []
      courses.each do |course|
        if course.user_ids.include?(id)
          user_courses << course
        end
      end
      courses = user_courses
    end
    courses
  end

  def courses_to_str
    course_string = ""
    courses.each do |course|
      course_string += course.name + "\n"
    end
    return course_string
  end

  def pending?
    pending == 0
  end


end
