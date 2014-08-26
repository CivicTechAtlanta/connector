class CreatePeopleOrganizations < ActiveRecord::Migration
  def change
    create_table :people_organizations do |t|
      t.integer :person_id, null: false
      t.integer :organization_id, null: false

      t.timestamps
    end

    add_index :people_organizations, [:person_id, :organization_id], unique: false
  end
end
