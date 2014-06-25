class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :person_id
      t.integer :project_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
