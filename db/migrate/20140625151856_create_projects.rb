class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :event_id
      t.integer :person_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
