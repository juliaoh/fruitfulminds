class CreatePresurveys < ActiveRecord::Migration
  def change
    create_table :presurveys do |t|
      t.integer :curriculum_id
      t.integer :course_id
      t.text :data
      t.text :total
      t.timestamps
    end
  end
end
