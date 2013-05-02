class AddBodyIdToDataFile < ActiveRecord::Migration
  def change
  	add_column :data_files, :body_id, :integer
  end
end
