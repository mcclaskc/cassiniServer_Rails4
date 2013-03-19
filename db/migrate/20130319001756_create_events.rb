class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :request
      t.string :start_scet
      t.string :end_scet

      t.timestamps
    end
  end
end
