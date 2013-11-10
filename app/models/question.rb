class Question < ActiveRecord::Base
  validates :name, :presence => true
  validates :type, :presence => true, :inclusion => ["Efficacy", "Multiple Choice"]
  validates :msg1, :presence => true
  validates :msg2, :presence => true

  belongs_to :section
  belongs_to :curriculum

end
