class CreateUsersCourses < ActiveRecord::Migration
  def up
    create_table :courses_users, :id => false do |t|
      t.references :user
      t.references :course
    end
    add_index :courses_users, [:user_id, :course_id]
    add_index :courses_users, :user_id
    add_index :courses_users, :course_id
  end

  def down
    drop_table :courses_users
  end
end
