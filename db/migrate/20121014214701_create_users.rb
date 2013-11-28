class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :profile_id
      t.integer :school_semester_id
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :pending
      t.integer :pending_school_id
      t.integer :pending_semester
      t.string :profile
      t.timestamps
    end
    add_index :users, :pending
  end
end
