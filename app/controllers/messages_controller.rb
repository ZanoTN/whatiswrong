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
      date = DateTime.parse(params[:occurred_at_start]) rescue nil
      @messages = @messages.where("occurred_at >= ?", date.beginning_of_day) if date
    end

    if params[:occurred_at_end].present?
      date = DateTime.parse(params[:occurred_at_end]) rescue nil
      @messages = @messages.where("occurred_at <= ?", date.end_of_day) if date
    end

    if params[:search].present?
      search = "%#{params[:search].to_s.downcase}%"
      @messages = @messages.where("LOWER(message) LIKE ? OR LOWER(backtrace) LIKE ? OR LOWER(context) LIKE ?", search, search, search)
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
