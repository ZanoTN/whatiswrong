class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [ :edit, :update, :destroy, :confirm_delete ]

  def new
    @notification = Notification.new
    render "_modal"
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to settings_path, notice: t("custom.notification.message.notification_created")
    else
      render "_modal", status: :unprocessable_entity
    end
  end

  def edit
    render "_modal"
  end

  def update
    if @notification.update(notification_params)
      redirect_to settings_path, notice: t("custom.notification.message.notification_updated")
    else
      render "_modal", status: :unprocessable_entity
    end
  end

  def confirm_delete
    render "_confirm_delete"
  end

  def destroy
    @notification.destroy
    redirect_to settings_path, notice: t("custom.notification.message.notification_deleted")
  end

  private

  def notification_params
    params.require(:notification).permit(:name, :service, :active, :level_info, :level_warning, :level_error, :chat_id, :bot_token, :webhook_url)
  end

  def set_notification
    @notification = Notification.find(params[:id])
    if @notification.nil?
      redirect_to settings_path, alert: t("custom.notification.message.notification_not_found")
    end
  end
end
