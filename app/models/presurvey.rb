class Presurvey < ActiveRecord::Base
  has_many :efficacy, :dependent => :destroy
  belongs_to :user
  belongs_to :school_semester
  belongs_to :course
  validates :total, :data, :presence => true

  delegate :school_name_and_semester, :to => :school_semester
end
