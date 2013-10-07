class Profile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :label
    end
  end

end
