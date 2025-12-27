class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from StandardError, with: :log_error

  before_action :set_theme
  before_action :set_locale

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def current_setting
    @current_setting ||= Setting.first
  end

  def set_theme
    @theme = current_setting&.default_theme || 'light'
  end

  def set_locale
    I18n.locale = current_setting&.language || I18n.default_locale
  end

  def log_error(error)
    unless error.instance_variable_defined?(:@logged)
      error.instance_variable_set(:@logged, true)
      Message.create(
        app: App.system_app,
        level: error_level(error),
        message: error.message,
        backtrace: error.backtrace.join("\n"),
        occurred_at: Time.now.utc.iso8601,
        context: JSON.generate({
          url: request.original_url,
          method: request.request_method,
          params: filtered_params,
          # cookies: request.cookies, # Avoid logging cookies for privacy/security reasons
          headers: filtered_headers,
          ip: request.remote_ip,
          user_agent: request.user_agent
        })
      )
    end

    raise error
  end

  def filtered_params
    request.filtered_parameters
  end

  def filtered_headers
    request.headers
           .env
           .select { |k, _| k.start_with?("HTTP_") }
           .except(
             "HTTP_AUTHORIZATION",
             "HTTP_COOKIE"
           )
  end

  def error_level(error)
    case error
    when ActiveRecord::RecordNotFound,
      ActionController::BadRequest,
      ActionController::UnpermittedParameters,
      ActionController::InvalidAuthenticityToken,
      ActionController::RoutingError
      'warning'
    else
      'error'
    end
  end
end
