class CreateReport < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :school_semester
      t.text "main_title"
      t.text "school_intro_title"
      t.text "school_introduction"
      t.text "eval_intro"
      t.text "strength_weakness_title"
      t.text "strengths"
      t.text "weaknesses"
      t.text "summary"

      t.timestamps
    end
  end
end
