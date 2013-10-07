class Presurvey::Part1 < ActiveRecord::Base
  belongs_to :school_semester
  validates_presence_of :school_semester_id, :section_1_1, :section_1_2, :section_2_1, :section_2_2, :section_2_3, :section_2_4, :section_3_1, :section_3_2, :section_3_3, :section_3_4, :section_3_5, :section_3_6, :section_4_1, :section_4_2, :section_4_3, :number_students
  validates_numericality_of :section_1_1, :section_1_2, :section_2_1, :section_2_2, :section_2_3, :section_2_4, :section_3_1, :section_3_2, :section_3_3, :section_3_4, :section_3_5, :section_3_6, :section_4_1, :section_4_2, :section_4_3, :number_students
end
