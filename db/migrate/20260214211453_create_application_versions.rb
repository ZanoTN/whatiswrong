class CreateApplicationVersions < ActiveRecord::Migration[8.1]
  def change
    create_table :application_versions do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
