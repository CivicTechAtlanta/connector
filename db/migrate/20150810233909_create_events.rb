class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.text :url
      t.text :location
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
