class Presurvey < ActiveRecord::Base
  has_many :efficacy, :dependent => :destroy
  belongs_to :user
  belongs_to :school_semester
  belongs_to :course
  belongs_to :curriculum
  serialize :data
  serialize :total

  delegate :users, :to => :course
end
