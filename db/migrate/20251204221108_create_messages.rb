class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.references :app, null: false, foreign_key: true

      t.string :level, null: false # 0: info, warning, error, etc.
      t.string :content, null: false
      t.text :details
      t.text :metadata
      t.text :stack_trace

      t.datetime :occurred_at, null: false

      t.timestamps
    end
  end
end
