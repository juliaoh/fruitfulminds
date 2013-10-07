class CreatePresurveyPart2s < ActiveRecord::Migration
  def change
    create_table :presurvey_part2s do |t|
      t.references :school_semester
      t.integer :number_students
      t.integer :section_5_1
      t.integer :section_5_2
      t.integer :section_6_1
      t.integer :section_6_2
      t.integer :section_6_3
      t.integer :section_6_4

      t.timestamps
    end
  end
end
