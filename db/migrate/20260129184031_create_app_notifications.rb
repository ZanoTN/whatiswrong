class CreateAppNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :app_notifications do |t|
      t.references :app, null: false, foreign_key: true
      t.references :notification, null: false, foreign_key: true

      t.boolean :level_info, default: false
      t.boolean :level_warning, default: false
      t.boolean :level_error, default: false

      t.timestamps

      t.index [ :app_id, :notification_id ], unique: true
    end

    # Remove the level in Notification as it's now per AppNotification
    remove_column :notifications, :level_info, :boolean, default: true, null: false
    remove_column :notifications, :level_warning, :boolean, default: true, null: false
    remove_column :notifications, :level_error, :boolean, default: true, null: false

    #  Create default AppNotifications for existing Apps and Notifications
    App.reset_column_information
    Notification.reset_column_information
    App.find_each do |app|
      Notification.find_each do |notification|
        if AppNotification.exists?(app: app, notification: notification)
          next
        end

        AppNotification.create!(
          app: app,
          notification: notification
        )
      end
    end
  end
end
