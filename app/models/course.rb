class Course < ActiveRecord::Base
  validates :semester, :presence => true
  validates :total_students, :presence => true

  belongs_to :school
  has_one :curriculum
  has_one :presurvey
  has_one :postsurvey
  has_many :users

end
