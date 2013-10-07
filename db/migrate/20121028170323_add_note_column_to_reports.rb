class AddNoteColumnToReports < ActiveRecord::Migration
  def change
    add_column :reports, :note, :text
  end
end
