class User < ActiveRecord::Base
  belongs_to :college
  has_and_belongs_to_many :courses
  has_secure_password
  validate :name, :presence => true
  validate :email, :presence => true, :uniqueness => true
  validate :password, :presence => true, :on => :create, :length => {:minimum => 6}
  validate :profile, :presence => true, :inclusion => ["ambassador", "admin"]
  validate :pending, :presence => true, :inclusion => [0, 1, 2]
  # pending = 0, approved = 1, on request for another course = 2
  strip_attributes

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
