class RemoveUserColumms < ActiveRecord::Migration
  def change
    remove_column :users, :image
    remove_column :users, :name
  end
end
