class CreatePresurveyPart1s < ActiveRecord::Migration
  def change
    create_table :presurvey_part1s do |t|
      t.references :school_semester
      t.integer :number_students
      t.integer :section_1_1
      t.integer :section_1_2
      t.integer :section_2_1
      t.integer :section_2_2
      t.integer :section_2_3
      t.integer :section_2_4
      t.integer :section_3_1
      t.integer :section_3_2
      t.integer :section_3_3
      t.integer :section_3_4
      t.integer :section_3_5
      t.integer :section_3_6
      t.integer :section_4_1
      t.integer :section_4_2
      t.integer :section_4_3

      t.timestamps
    end
  end
end
