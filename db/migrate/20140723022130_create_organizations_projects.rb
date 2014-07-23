class CreateOrganizationsProjects < ActiveRecord::Migration
  def change
    create_table :organizations_projects do |t|
      t.integer :organization_id, null: false
      t.integer :project_id, null: false

      t.timestamps
    end

    add_index :organizations_projects, [:organization_id, :project_id], unique: true
  end
end
