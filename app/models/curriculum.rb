class Curriculum < ActiveRecord::Base
  validates :name, :presence => true
  has_many :sections, dependent: :destroy
  has_many :questions, through: :sections, dependent: :destroy
end
