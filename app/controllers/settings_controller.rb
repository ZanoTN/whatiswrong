class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @settings = Setting.last
  end

  def update
    @settings = Setting.first
    if @settings.update!(settings_params)
      redirect_to settings_path, notice: 'Settings updated successfully.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def settings_params
    params.require(:setting).permit(:language, :default_theme)
  end
end
