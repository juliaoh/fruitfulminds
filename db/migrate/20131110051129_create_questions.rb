class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name, :null => false
      t.string :type, :null => false
      t.string :msg1
      t.string :msg2
      t.string :description

      t.timestamps
    end
  end
end
