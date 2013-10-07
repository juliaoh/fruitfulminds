class CreateFoodJournals < ActiveRecord::Migration
  def change
    create_table :food_journals do |t|
      t.references :school_semester
      t.string  :student_name
      t.integer :week_num
      t.integer :fruit
      t.integer :vegetable
      t.integer :sugary_drink
      t.integer :water

      t.timestamps
    end
  end
end
