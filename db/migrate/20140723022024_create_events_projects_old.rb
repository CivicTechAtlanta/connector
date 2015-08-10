class CreateEventsProjectsOld < ActiveRecord::Migration
  def change
    create_table :events_projects do |t|
      t.integer :event_id, null: false
      t.integer :project_id, null: false

      t.timestamps
    end

    add_index :events_projects, [:event_id, :project_id], unique: true
  end
end
