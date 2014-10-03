class RemoveEvents < ActiveRecord::Migration
  def change
    drop_table :events
    drop_table :events_people
    drop_table :events_projects
  end
end
