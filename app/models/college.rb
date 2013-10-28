class College < ActiveRecord::Base
  has_many :users
  validates :name, :presence => true
  strip_attributes


end
