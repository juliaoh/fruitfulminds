class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.float :delta
      t.text :strengths
      t.text :weaknesses
      t.text :competencies
      t.string :admin_message
      t.string :report_link
      t.timestamps
    end
  end
end
