class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.string :name, null: false
      t.string :service, null: false
      t.jsonb :configuration, null: false, default: {}

      t.boolean :active, null: false, default: true
      t.boolean :level_info, null: false, default: true
      t.boolean :level_warning, null: false, default: true
      t.boolean :level_error, null: false, default: true

      t.timestamps
    end
  end
end
