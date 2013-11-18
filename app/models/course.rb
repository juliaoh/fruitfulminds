class Course < ActiveRecord::Base
  validates :semester, :presence => true
  validates :total_students, :presence => true
  belongs_to :school
  has_and_belongs_to_many :users
  has_one :presurvey
  has_one :postsurvey

  validates :active, :presence => true, :inclusion => [true, false]


  def name
    school.name + ", " + school.city + ", " + school.county + ", " + semester
  end

  def active?
    active
  end

  def curriculum
    Curriculum.find(curriculum_id)
  end
end
