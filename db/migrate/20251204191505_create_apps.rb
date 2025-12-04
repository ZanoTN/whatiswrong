class CreateApps < ActiveRecord::Migration[8.1]
  def change
    create_table :apps do |t|
      t.string :name, null: false
      t.string :api_key, null: false
      t.datetime :last_used_at

      t.timestamps
    end

    add_index :apps, :name, unique: true
    add_index :apps, :api_key, unique: true
  end
end
