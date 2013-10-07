class CreatePendingUsers < ActiveRecord::Migration
  def change
    create_table :pending_users, :id => false do |t|
      t.integer :user_id, :unique => true

      t.timestamps
    end
    add_index :pending_users, :user_id, :unique => true
  end
end
