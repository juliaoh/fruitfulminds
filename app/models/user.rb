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

  def pending?
    pending == 0
  end

  def pending_semester_select
  end
end
