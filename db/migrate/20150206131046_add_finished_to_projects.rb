class AddFinishedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :finished, :boolean, :default => false
    add_index  :projects, :finished
  end
end
