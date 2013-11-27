class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.string :name
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
