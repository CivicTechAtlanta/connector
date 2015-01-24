class ChangeTitleToBeStringOnComments < ActiveRecord::Migration
  def up
    change_column :comments, :title, :string, default: ""
  end

  def down
    change_column :comments, :title, :string, limit: 50, default: ""
  end
end
