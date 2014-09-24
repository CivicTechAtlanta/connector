class RemoveUserColumms < ActiveRecord::Migration
  def up
    remove_column :users, :image, :string
    remove_column :users, :name, :string
  end
end
