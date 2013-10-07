class SchoolSemester < ActiveRecord::Base
  has_many :users
  has_many :presurvey_part1s, :class_name => "Presurvey::Part1"
  has_many :presurvey_part2s, :class_name => "Presurvey::Part2"
  has_many :postsurveys
  has_many :food_journals
  belongs_to :school
end
