class AddDistrictToPendingUsers < ActiveRecord::Migration
  def change
    add_column :pending_users, :school_district, :string
  end
end
