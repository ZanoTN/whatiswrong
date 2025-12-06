class EditMessages < ActiveRecord::Migration[8.1]
  def change
    drop_table :messages

    create_table :messages do |t|
      t.references :app, foreign_key: true, null: false
      t.string :level, null: false
      t.string :message, null: false
      t.text :backtrace
      t.text :context
      t.datetime :occurred_at, null: false

      t.timestamps
    end
  end
end