class CreateUsersCourses < ActiveRecord::Migration
  def up
    create_table :users_courses, :id => false do |t|
      t.references :user
      t.references :course
    end
    add_index :users_courses, [:user_id, :course_id]
    add_index :users_courses, :user_id
    add_index :users_courses, :course_id
  end

  def down
    drop_table :users_courses
  end
end
