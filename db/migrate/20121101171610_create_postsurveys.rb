class CreatePostsurveys < ActiveRecord::Migration
  def change
    create_table :postsurveys do |t|
      t.references :school_semester
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
      t.integer :section_5_1
      t.integer :section_5_2
      t.integer :section_6_1
      t.integer :section_6_2
      t.integer :section_6_3
      t.integer :section_6_4
      t.integer :number_students

      t.timestamps
    end
  end
end
