class AddShortDescriptionAndLinkToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :short_description, :string
    add_column :projects, :link, :string
  end
end
