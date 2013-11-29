class CreateStaticContents < ActiveRecord::Migration
  def change
    create_table :static_contents do |t|
      t.references 'report'
      t.text "intro_title"
      t.text "introduction"
      t.text "objectives_title"
      t.text "objectives"
      t.text "eval_title"
      t.text "strength_weakness_intro"
      t.text "strength_intro"
      t.text "weakness_intro"
      t.text "comp_intro"
      t.text "summary"
      t.text "behavior_title"
      t.text "behavior_intro"
      t.text "slight_increase_header"
      t.text "increase_header"
      t.text "decrease_header"
      t.text "comp_header"
      t.text "slight_decrease_header"
      t.text "summary_header"


      t.timestamps
    end
  end
end
