class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string, :semester, :null => false;
      t.integer :total_students, :null => false;
      t.timestamps
    end
  end
end
