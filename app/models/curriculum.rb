class Curriculum < ActiveRecord::Base
  validates :name, :presence => true
  has_many :sections, dependent: :destroy


  def create_and_save_section(options = {})
    section = Section.new(options)
    section.save
  end

end
