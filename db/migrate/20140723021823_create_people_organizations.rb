class CreatePeopleOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations_people do |t|
      t.integer :person_id, null: false
      t.integer :organization_id, null: false

      t.timestamps
    end

    add_index :organizations_people, [:person_id, :organization_id], unique: false
  end
end
