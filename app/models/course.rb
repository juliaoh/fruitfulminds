class Course < ActiveRecord::Base
  validates :semester, :presence => true
  validates :total_students, :presence => true
  belongs_to :school
  has_and_belongs_to_many :users
  has_one :presurvey
  has_one :postsurvey
  has_one :report

  validates :active, :presence => true, :inclusion => [0,1]

  after_find :check_active
  after_create :check_active

  def name
    school.name + ", " + school.city + ", " + school.county + ", " + semester
  end

  def active?
    active == 1
  end

  def curriculum
    Curriculum.find(curriculum_id)
  end

  def check_active
    if compare_semester(get_time_of_year) == 1
      update_attributes!(:active => 0)
    else
      update_attributes!(:active => 1)
    end
  end

  def get_time_of_year
    if Time.now.year.month < 7
      month = "Spring"
    else
      month = "Fall"
    end
    return "#{month} #{Time.now.year}"
  end

  def compare_name_and_semester(other)
    temp = compare_semester(other.semester)
    case
    when temp == 0
      name <=> other.name
    else
      temp
    end
  end

  def compare_semester(other)
    semesterA = semester.split(" ")
    semesterB = other.split(" ")
    case
    when semesterA[1] < semesterB[1]
      1
    when semesterA[1] > semesterB[1]
      -1
    else
      semesterA[0] <=> semesterB[0]
    end
  end
end
