class MessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @message = Message.find(params[:id])
    if @message.nil?
      redirect_to root_path, alert: "Message not found."
    end
  end
end
