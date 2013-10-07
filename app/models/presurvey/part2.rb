class Presurvey::Part2 < ActiveRecord::Base
  belongs_to :school_semester
  has_many :efficacy, :dependent => :destroy
  validates_presence_of :school_semester_id, :section_5_1, :section_5_2, :section_6_1, :section_6_2, :section_6_3, :section_6_4, :number_students
  validates_numericality_of :section_5_1, :section_5_2, :section_6_1, :section_6_2, :section_6_3, :section_6_4, :number_students
end
