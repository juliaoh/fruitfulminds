class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|

      t.timestamps
    end
  end
end
