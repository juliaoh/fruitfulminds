class AddCourseIdToReport < ActiveRecord::Migration
  def change
    add_column :reports, :course_id, :integer
  end
end
