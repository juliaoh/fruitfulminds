class FoodJournal < ActiveRecord::Base
  belongs_to :school_semester
  belongs_to :user

  validates_numericality_of :week_num, :fruit, :vegetable, :sugary_drink, :water
  validates :student_name, :presence => true

  strip_attributes :only => :student_name
end
