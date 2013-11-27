class Question < ActiveRecord::Base
  validates :name, :presence => true
  validates :qtype, :presence => true, :inclusion => ["Efficacy", "Multiple Choice"]
  validates :msg, :presence => true

  belongs_to :section

end
