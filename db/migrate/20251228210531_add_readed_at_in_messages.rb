class AddReadedAtInMessages < ActiveRecord::Migration[8.1]
  def change
    add_column :messages, :readed_at, :datetime, default: nil
  end
end
