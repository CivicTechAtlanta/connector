class AddFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :short_description, :text
    add_column :projects, :link, :string
  end
end
