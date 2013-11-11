class Presurvey < ActiveRecord::Base
  has_many :efficacy, :dependent => :destroy
  belongs_to :user
  belongs_to :school_semester
  serialize :data
  serialize :total
  validates_presence_of :school_semester_id
  validates :number_students, :presence => true
  validates :curriculum_id, :presence => true
  validates :course_id, :presence => true

  delegate :school_name_and_semester, :to => :school_semester
end
