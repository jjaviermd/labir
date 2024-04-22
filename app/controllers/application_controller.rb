# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :authenticate_laboratory!, unless: :devise_controller?

  before_action :set_current_laboratory

  private

  def set_current_laboratory
    Current.laboratory = current_laboratory
  end
end
