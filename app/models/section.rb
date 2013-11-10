class Section < ActiveRecord::Base
  validates :name, :presence => true
  validates :type, :presence => true, :inclusion => ["Efficacy", "Multiple Choice"]
  validates :objective, :presence => true, :if => "is_multiple_choice?"
  validates :objective, :inclusion => [nil], :if => "is_not_multiple_choice?"

  has_many :questions, dependent: :destroy
  belongs_to :curriculum

  def is_multiple_choice?
    type == "Multiple Choice"
  end

  def is_not_multiple_choice?
    !is_multiple_choice?
  end
end
