class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.float :delta
      t.text :strengths
      t.text :weaknesses
      t.text :competencies
      t.text :efficacy_strengths
      t.text :efficacy_weaknesses
      t.text :efficacy_competencies
      t.string :ambassador_message
      t.string :report_link
      t.timestamps
    end
  end
end
