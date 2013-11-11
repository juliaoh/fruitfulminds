class Efficacy < ActiveRecord::Base
  belongs_to :presurvey
  belongs_to :postsurvey
  validates_presence_of :efficacy_1, :efficacy_2, :efficacy_3, :efficacy_4, :efficacy_5, :efficacy_6, :efficacy_7, :efficacy_8, :efficacy_9, :efficacy_10, :number_students
  validates_numericality_of :efficacy_1, :efficacy_2, :efficacy_3, :efficacy_4, :efficacy_5, :efficacy_6, :efficacy_7, :efficacy_8, :efficacy_9, :efficacy_10, :number_students
end
