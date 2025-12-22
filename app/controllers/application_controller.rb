class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_theme


  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def set_theme
    if current_user.nil?
      return 'light'
    end

    @theme = Setting.first.default_theme || 'light'
  end


end
