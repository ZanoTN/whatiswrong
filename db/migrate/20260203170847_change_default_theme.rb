class ChangeDefaultTheme < ActiveRecord::Migration[8.1]
  def change
    change_column_default :settings, :default_theme, 'dark'
  end
end
