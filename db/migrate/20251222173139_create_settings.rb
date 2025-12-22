class CreateSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :settings do |t|
      t.string :language, null: false, default: 'en'
      t.string :default_theme, null: false, default: 'light'


      t.timestamps
    end
  end
end
