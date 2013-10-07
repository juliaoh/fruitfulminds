class Profile < ActiveRecord::Base
  has_many :users
  validates_uniqueness_of :label

  ADMIN = 'admin'
  AMBASSADOR = 'ambassador'
end
