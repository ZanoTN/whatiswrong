class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.order(occurred_at: :desc).joins(:app).page(params[:page]).per(20)
  end

  def show
    @message = Message.find(params[:id])
    if @message.nil?
      redirect_to root_path, alert: "Message not found."
    end
  end
end
