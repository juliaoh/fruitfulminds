class AddIdentifierToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :identifier, :string
  end
end
