class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :semester, :null => false;
      t.integer :total_students, :null => false;
      t.integer :school_id, :null => false;
      t.integer :curriculum_id, :null => false;
      t.integer :presurvey_id, :null => false;
      t.integer :postsurvey_id, :null => false;
      t.boolean :active
      t.timestamps
    end
  end
end
