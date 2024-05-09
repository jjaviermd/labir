# frozen_string_literal: true

class Pathologists::SessionsController < Devise::SessionsController
  after_action :authenticate_activity, only: :create

  private
  def authenticate_activity
    if current_pathologist.is_inactive?
      flash[:inactive_pathologist] = ""
      sign_out current_pathologist
    end
  end
end
