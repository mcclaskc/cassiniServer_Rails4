class CreateDataFiles < ActiveRecord::Migration
  def change
    create_table :data_files do |t|
      t.string :path
      t.date :file_date
      t.integer :file_type_id

      t.timestamps
    end
  end
end
