class Curriculum < ActiveRecord::Base
  validates :name, :presence => true
  has_many :sections, dependent: :destroy


  def create_and_save_section(options = {})
    section = Section.new(options)
    section.curriculum_id = id
    section.save
    return section
  end

  def get_empty_data
    data = {}
    sections.each do |section|
      section.questions.each do |question|
        data[question.id] = 0
      end
    end
    return data
  end
end
