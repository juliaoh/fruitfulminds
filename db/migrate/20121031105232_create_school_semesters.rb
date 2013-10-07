class CreateSchoolSemesters < ActiveRecord::Migration

  def change
    create_table :school_semesters do |t|
      t.integer :school_id
      t.string :name
      t.integer :year
    end
  end

end
