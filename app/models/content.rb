class Content < ActiveRecord::Base
  belongs_to :school
  validate :school_id, :presence => true
end
