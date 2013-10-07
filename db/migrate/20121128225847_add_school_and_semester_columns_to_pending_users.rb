class AddSchoolAndSemesterColumnsToPendingUsers < ActiveRecord::Migration
  def change
    add_column :pending_users, :school_city, :string
    add_column :pending_users, :school_name, :string
    add_column :pending_users, :school_county, :string
    add_column :pending_users, :semester_name, :string
    add_column :pending_users, :semester_year, :integer
  end
end
