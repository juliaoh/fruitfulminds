class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name, :null => false
      t.string :qtype, :null => false
      t.string :msg
      t.string :description

      t.timestamps
    end
  end
end
