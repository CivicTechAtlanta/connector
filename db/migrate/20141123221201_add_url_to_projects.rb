class AddUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :url, :text
  end
end
