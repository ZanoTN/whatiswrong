class ExternalApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:add_message_v1]
  before_action :set_app_by_api_key, only: [:add_message_v1]

  # PUT /api/v1/message
  def add_message_v1
    message_params = params.permit(:level, :message, :context, :backtrace, :occurred_at)

    if message_params[:level].blank? || message_params[:message].blank?
      return render json: { error: 'Level and message are required' }, status: :bad_request
    end

    unless Message.levels.include?(message_params[:level])
      return render json: { error: 'Invalid level' }, status: :bad_request
    end

    message = @app.messages.new(message_params)

    if message.save
      render json: { message: 'Log message created successfully' }, status: :created
    else
      render json: { error: 'Failed to create log message' }, status: :unprocessable_entity
    end
  end

  private

  def set_app_by_api_key
    if params[:key].blank?
      render json: { error: 'API key is required' }, status: :unauthorized and return
    end

    @app = App.find_by(api_key: params[:key])

    if @app.nil?
      render json: { error: 'Invalid API key' }, status: :unauthorized and return
    end
  end
end