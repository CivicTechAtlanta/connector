class AddUrlsToProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :url, :text
    add_column :projects, :urls, :json, default: []
  end
end
