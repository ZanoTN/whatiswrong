class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @apps = App.all

    @messages = Message.order(occurred_at: :desc).joins(:app)

    if params[:app_id].present?
      @messages = @messages.where(app_id: params[:app_id])
    end

    if params[:level].present?
      @messages = @messages.where(level: params[:level])
    end

    if params[:occurred_at_start].present?
      @messages = @messages.where("occurred_at >= ?", params[:occurred_at_start])
    end

    if params[:occurred_at_end].present?
      @messages = @messages.where("occurred_at <= ?", params[:occurred_at_end])
    end

    @messages = @messages.page(params[:page]).per(20)
  end

  def show
    @message = Message.find(params[:id])
    if @message.nil?
      redirect_to root_path, alert: "Message not found."
    end
  end
end
