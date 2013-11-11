class Postsurvey < ActiveRecord::Base
  has_many :efficacy, :dependent => :destroy
  belongs_to :user
  belongs_to :school_semester
  serialize :data
  serialize :total
  belongs_to :course
end
