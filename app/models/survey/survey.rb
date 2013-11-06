class Survey < ActiveRecord::Base
  has_many :efficacy, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  belongs_to :user
  belongs_to :school_semester
end
