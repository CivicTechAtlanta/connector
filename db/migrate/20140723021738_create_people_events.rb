class CreatePeopleEvents < ActiveRecord::Migration
  def change
    create_table :people_events do |t|
      t.integer :person_id, null: false
      t.integer :event_id, null: false

      t.timestamps
    end

    add_index :people_events, [:person_id, :event_id], unique: true
  end
end
