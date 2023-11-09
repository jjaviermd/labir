# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_laboratory!
  # protect_from_forgery with: :exception

  # before_action :update_allowed_parameters, if: :devise_controller?

  # protected

  # def update_allowed_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) do |u|
  #     u.permit(:email, :name, :address, :phone_number, :account, :password)
  #   end
  #   devise_parameter_sanitizer.permit(:account_update) do |u|
  #     u.permit(:email, :name, :address, :phone_number, :account, :password, :current_password)
  #   end
  # end
end
