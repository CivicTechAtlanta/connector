class CreatePeopleEventsOld < ActiveRecord::Migration
  def change
    create_table :events_people do |t|
      t.integer :person_id, null: false
      t.integer :event_id, null: false

      t.timestamps
    end

    add_index :events_people, [:person_id, :event_id], unique: true
  end
end
