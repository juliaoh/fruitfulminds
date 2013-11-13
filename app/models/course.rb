class Course < ActiveRecord::Base
  validates :semester, :presence => true
  validates :total_students, :presence => true
  belongs_to :school
  has_and_belongs_to_many :users
  has_one :curriculum
  has_one :presurvey
  has_one :postsurvey

  validates :active, :presence => true, :inclusion => [true, false]


  def name
    school.name + ", " + school.county + ", " + school.city + ", " + semester
  end

  def active?
    active
  end
end
