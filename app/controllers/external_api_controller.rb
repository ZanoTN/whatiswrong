class ExternalApiController < ApplicationController
  def add_message_v1
    # Expected params: {
    #  api_key: string,
    #  level: string ("info", "warning", "error"),
    #  message: string,
    #  context: string (optional)
    #  backtrace: string (optional)
    #  occurred_at: datetime (optional)
    # }

    set_app_by_api_key

    message_params = params.permit(:level, :message, :context, :backtrace, :occurred_at)

    if message_params[:level].nil? || message_params[:level].empty? ||
        message_params[:message].nil? || message_params[:message].empty?
      render json: { error: 'Level and message are required' }, status: :bad_request and return
    end

    unless Message.levels.include? message_params[:level]
      render json: { error: 'Invalid level' }, status: :bad_request and return
    end

    message = @app.messages.new(message_params)
    if message.save
      render json: { message: 'Log message created successfully', id: message.id }, status: :created
    else
      render json: { error: 'Failed to create log message' }, status: :unprocessable_entity
    end
  end


  private

  def set_app_by_api_key
    if params[:api_key].nil? || params[:api_key].empty?
      render json: { error: 'API key is required' }, status: :unauthorized and return
    end
    @app = App.find_by(api_key: params[:api_key])

    if @app.nil?
      render json: { error: 'Invalid API key' }, status: :unauthorized and return
    end
  end

end
