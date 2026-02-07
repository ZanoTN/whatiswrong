class UsersController < ApplicationController
  before_action :authenticate_user!

  def me
    @current_user = current_user
  end

  def update_me
    if ApplicationHelper.is_demo_version?
      # In demo mode, prevent profile updates and show a message
      redirect_to me_users_path, alert: t("custom.demo.update_profile_disabled")
      return
    end

    if current_user.update_with_password(update_me_params)
      redirect_to me_users_path, notice: t("custom.user.message.profile_updated")
    else
      render :me, status: :unprocessable_entity
    end
  end

  private

  def update_me_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
