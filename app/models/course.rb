class Course < ActiveRecord::Base
  validates :semester, :presence => true
  validates :total_students, :presence => true
  validates :school_id, :presence => true, :numericality => true
  validates :curriculum_id, :presence => true, :numericality => true
  validates :presurvey_id, :presence => true, :numericality => true
  validates :postsurvey_id, :presence => true, :numericality => true

  has_and_belongs_to_many :users

  def name
  	School.find_by_id(school_id).name + " " + semester
  end
end
