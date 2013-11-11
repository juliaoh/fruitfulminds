class Presurvey < ActiveRecord::Base
  has_many :efficacy, :dependent => :destroy
  belongs_to :user
  belongs_to :school_semester
  belongs_to :course
  serialize :data
  serialize :total

end
