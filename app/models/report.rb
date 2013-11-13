class Report < ActiveRecord::Base
  belongs_to :course
  validate :course_id, :presence => true
  has_one :amb_note

end