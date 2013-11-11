class SchoolSemester < ActiveRecord::Base
  has_many :users
  has_many :presurveys
  has_many :postsurveys
  has_many :food_journals
  belongs_to :school

  def school_name_and_semester
    school = School.find_by_id(school_id)
    "#{school.name}: #{name} #{year}"
  end
end
