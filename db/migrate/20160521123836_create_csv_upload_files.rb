class CreateCsvUploadFiles < ActiveRecord::Migration
  def change
    create_table :csv_upload_files do |t|
      t.string :name
      t.string :attachment

      t.timestamps null: false
    end
  end
end
