# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :user_not_exists?, only: [:new]
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  private

  def user_not_exists?
    if User.count == 0
      flash[:alert] = "No users exist. Please register first."
      redirect_to new_user_registration_path
    end
  end
end
