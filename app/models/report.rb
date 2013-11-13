#this will replace repport.rb

class Report < ActiveRecord::Base
  belongs_to :course
  validate :course_id, :presence => true

end