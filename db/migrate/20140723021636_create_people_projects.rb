class CreatePeopleProjects < ActiveRecord::Migration
  def change
    create_table :people_projects do |t|
      t.integer :person_id, null: false
      t.integer :project_id, null: false

      t.timestamps
    end

    add_index :people_projects, [:person_id, :project_id], unique: true
  end
end
