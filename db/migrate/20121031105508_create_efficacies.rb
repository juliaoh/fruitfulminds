class CreateEfficacies < ActiveRecord::Migration
  def change
    create_table :efficacies do |t|
      t.references :postsurvey
      t.integer :part2_id
      t.integer :efficacy_1
      t.integer :efficacy_2
      t.integer :efficacy_3
      t.integer :efficacy_4
      t.integer :efficacy_5
      t.integer :efficacy_6
      t.integer :efficacy_7
      t.integer :efficacy_8
      t.integer :efficacy_9
      t.integer :efficacy_10
      t.integer :number_students

      t.timestamps
    end
  end
end
