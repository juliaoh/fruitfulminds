class Curriculum < ActiveRecord::Base
  validates :name, :presence => true
  has_many :sections, dependent: :destroy


  def create_and_save_section(options = {})
    section = Section.new(options)
    section.curriculum_id = id
    section.save
    return section
  end

end
