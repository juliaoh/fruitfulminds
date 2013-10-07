class School < ActiveRecord::Base
  has_many :school_semesters
  has_many :users, :through => :school_semesters
  has_many :presurvey_part1s, :through => :school_semesters, :class_name => "Presurvey::Part1"
  has_many :presurvey_part2s, :through => :school_semesters, :class_name => "Presurvey::Part2"
  has_many :postsurveys, :through => :school_semesters
  has_many :reports #, :through => :surveys
  validates :name, :county, :city, :presence => true
  strip_attributes

  def has_all_report_data
    # TODO: add food journal requirement here as well
    not(presurvey_part1s.empty? or presurvey_part2s.empty? or postsurveys.empty?)
  end
end
