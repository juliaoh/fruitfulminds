class DynamicContent < ActiveRecord::Base
  belongs_to :report
  validate :school_id, :presence => true
end
