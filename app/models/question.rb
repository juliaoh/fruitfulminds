class Question < ActiveRecord::Base
  validates :name, :presence => true
  validates :type, :presence => true, :inclusion => ["Efficacy", "Multiple Choice"]
  validates :msg1, :presence => true, :if => "is_efficacy?"
  validates :msg2, :presence => true, :if => "is_efficacy?"
  validates :msg1, :inclusion => [nil], :if => "is_not_efficacy?"
  validates :msg2, :inclusion => [nil], :if => "is_not_efficacy?"

  belongs_to :section
  belongs_to :curriculum

  def is_efficacy?
    type == "Efficacy"
  end

  def is_not_efficacy?
    !is_efficacy?
  end

end
