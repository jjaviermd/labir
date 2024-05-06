# frozen_string_literal: true

class Pathologists::SessionsController < Devise::SessionsController
  after_action :authenticate_activity, only: :create

  private
  def authenticate_activity
    if current_pathologist.is_inactive?
      flash[:danger] = "Your account is currently inactive, please contact your laborarory administrator to change yous activity status"
      sign_out current_pathologist
    end
  end
end
