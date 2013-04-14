class CreateEphems < ActiveRecord::Migration
  def change
    create_table :ephems do |t|
      t.float :x
      t.float :y
      t.float :z
      t.datetime :timestamp
      t.integer :body_id

      t.timestamps
    end
  end
end
