class Report < ActiveRecord::Base
  belongs_to :school_semester
  has_one    :static_contents
  has_one    :dynamic_contents
  validate :school_semester_id, :presence => true
end
