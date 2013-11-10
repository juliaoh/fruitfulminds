class Section < ActiveRecord::Base
  validates :name, :presence => true
  validates :type, :presence => true, :inclusion => ["Efficacy", "Multiple Choice"]
  validates :objective, :presence => true, :if => "is_efficacy?"
  validates :objective, :inclusion => [nil], :if => "is_not_efficacy?"

  has_many :questions, dependent: :destroy
  belongs_to :curriculum

  def is_efficacy?
    type == "Efficacy"
  end

  def is_not_efficacy?
    !is_efficacy?
  end
end
