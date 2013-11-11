class Presurvey < ActiveRecord::Base
  has_many :efficacy, :dependent => :destroy
  belongs_to :user
  belongs_to :school_semester
  belongs_to :course
  serialize :data
  serialize :total

  delegate :school_name_and_semester, :to => :school_semester
end
