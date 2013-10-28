class College < ActiveRecord::Base
  has_many :college_semesters
  has_many :users, :through => :college_semesters
  validates :name, :presence => true
  strip_attributes


end
