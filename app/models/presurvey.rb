class Presurvey < ActiveRecord::Base
  belongs_to :course
  belongs_to :curriculum
  serialize :data
  serialize :total
end
