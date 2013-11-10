class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name, :null => false
      t.string :objective
      t.string :type, :null => false

      t.timestamps
    end
  end
end
