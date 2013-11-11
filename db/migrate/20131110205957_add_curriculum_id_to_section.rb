class AddCurriculumIdToSection < ActiveRecord::Migration
  def change
    add_column :sections, :curriculum_id, :integer
  end
end
